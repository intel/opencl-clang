static unsigned int index(unsigned int x, unsigned int y, unsigned int z, unsigned int dim) {
	return (x * (dim+2) * (dim+2)) + (y * (dim+2)) + z;
}

static unsigned int vindex(unsigned int x, unsigned int y, unsigned int z, unsigned int d, unsigned int dim) {
	return (3 * index(x, y, z, dim)) + d;
}

// Initializes the scalar temp fields
__kernel void vectorInitField(__global float *field, const unsigned int dim) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 2);

	if(x < lim && y < lim && z < lim) {
		unsigned int i = index(x, y, z, dim);
		field[i] = 0.0;
	}
}

__kernel void vectorAddField(__global float *field, __global float *srcField, const unsigned int dim, const float dt) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 2);

	if(x < lim && y < lim && z < lim) {
		unsigned int i = vindex(x, y, z, 0, dim);
		unsigned int j = vindex(x, y, z, 1, dim);
		unsigned int k = vindex(x, y, z, 2, dim);
		field[i] += srcField[i] * dt;
		field[j] += srcField[j] * dt;
		field[k] += srcField[k] * dt;
	}
}

__kernel void vectorCopy(__global float *field, __global float *tempField, const unsigned int dim) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 2);

	if(x < lim && y < lim && z < lim) {
		unsigned int i = vindex(x, y, z, 0, dim);
		unsigned int j = vindex(x, y, z, 1, dim);
		unsigned int k = vindex(x, y, z, 2, dim);

		tempField[i] = field[i];
		tempField[j] = field[j];
		tempField[k] = field[k];
	}
}

//TODO: this is slip only - implement noslip
__kernel void vectorBoundaries(__global float *field, const unsigned int dim) {
	unsigned int i = get_global_id(0);
	unsigned int j = get_global_id(1);

	unsigned int lim = (dim + 1);

	if(i < lim+1 && j < lim+1 && !((i == 0 && (j == 0 || j == lim)) || (i == lim && (j == 0 || j == lim)))) {
		field[vindex(0, i, j, 0, dim)] = field[vindex(1, i, j, 0, dim)] * (-1); //left boundary
		field[vindex(dim+1, i, j, 0, dim)] = field[vindex(dim, i, j, 0, dim)]* (-1); //right boundary
		field[vindex(i, 0, j, 1, dim)] = field[vindex(i, 1, j, 1, dim)]* (-1); // bottom boundary
		field[vindex(i, dim+1, j, 1, dim)] = field[vindex(i, dim, j, 1, dim)]* (-1); // top boundary
		field[vindex(i, j, 0, 2, dim)] = field[vindex(i, j, 1, 2, dim)]* (-1); // back boundary
		field[vindex(i, j, dim+1, 2, dim)] = field[vindex(i, j, dim, 2, dim)]* (-1); // top boundary
	}

	// Corner velocities
	if(i == 0 && j == 0) {
		for(int d = 0; d < 3; d++) {
			field[vindex(0,0,0,d,dim)] = (field[vindex(1,0,0,d,dim)] + field[vindex(0,1,0,d,dim)] + field[vindex(0,0,1,d,dim)]) / 3;
			field[vindex(0,dim+1,0,d,dim)] = (field[vindex(1,dim+1,0,d,dim)] + field[vindex(0,dim,0,d,dim)] + field[vindex(0,dim+1,1,d,dim)]) / 3;
			field[vindex(dim+1,0,0,d,dim)] = (field[vindex(dim,0,0,d,dim)] + field[vindex(dim+1,1,0,d,dim)] + field[vindex(dim+1,0,1,d,dim)]) / 3;
			field[vindex(dim+1,dim+1,0,d,dim)] = (field[vindex(dim,dim+1,0,d,dim)] + field[vindex(dim+1,dim,0,d,dim)] + field[vindex(dim+1,dim+1,1,d,dim)]) / 3;
			field[vindex(0,0,dim+1,d,dim)] = (field[vindex(1,0,dim+1,d,dim)] + field[vindex(0,1,dim+1,d,dim)] + field[vindex(0,0,dim,d,dim)]) / 3;
			field[vindex(0,dim+1,dim+1,d,dim)] = (field[vindex(1,dim+1,dim+1,d,dim)] + field[vindex(0,dim,dim+1,d,dim)] + field[vindex(0,dim+1,dim,d,dim)]) / 3;
			field[vindex(dim+1,0,dim+1,d,dim)] = (field[vindex(dim,0,dim+1,d,dim)] + field[vindex(dim+1,1,dim+1,d,dim)] + field[vindex(dim+1,0,dim,d,dim)]) / 3;
			field[vindex(dim+1,dim+1,dim+1,d,dim)] = (field[vindex(dim,dim+1,dim+1,d,dim)] + field[vindex(dim+1,dim,dim+1,d,dim)] + field[vindex(dim+1,dim+1,dim,d,dim)]) / 3;
		}
	}
}

__kernel void vectorVorticityConfinementFirst(__global float *field, __global float *tempVec, __global float *tempField, const unsigned int dim, const float dt0) {
	unsigned int z = get_global_id(2);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(0);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		float x,y,z;

		x = tempVec[vindex(x,y,z,0,dim)] = ((field[vindex(x,y+1,z,2,dim)] - field[vindex(x,y-1,z,2,dim)]) * 0.5) - ((field[vindex(x,y,z+1,1,dim)] - field[vindex(x,y,z-1,1,dim)]) * 0.5);
		y = tempVec[vindex(x,y,z,1,dim)] = ((field[vindex(x,y,z+1,0,dim)] - field[vindex(x,y,z-1,0,dim)]) * 0.5) - ((field[vindex(x+1,y,z,2,dim)] - field[vindex(x-1,y,z,2,dim)]) * 0.5);
		z = tempVec[vindex(x,y,z,2,dim)] = ((field[vindex(x+1,y,z,1,dim)] - field[vindex(x-1,y,z,1,dim)]) * 0.5) - ((field[vindex(x,y+1,z,0,dim)] - field[vindex(x,y-1,z,0,dim)]) * 0.5);

		tempField[index(x,y,z,dim)] = sqrt((x*x) + (y*y) + (z*z));
	}
}

__kernel void vectorVorticityConfinementSecond(__global float *field, __global float *tempVec, __global float *tempField, const unsigned int dim, const float dt0) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		float Nx = (tempField[index(x+1,y,z,dim)] - tempField[index(x-1,y,z,dim)]) * 0.5;
		float Ny = (tempField[index(x,y+1,z,dim)] - tempField[index(x,y-1,z,dim)]) * 0.5;
		float Nz = (tempField[index(x,y,z+1,dim)] - tempField[index(x,y,z-1,dim)]) * 0.5;
		float len1 = 1.0/(sqrt((Nx*Nx) + (Ny*Ny) + (Nz*Nz)) + 0.0000001);

		Nx *= len1;
		Ny *= len1;
		Nz *= len1;

		field[vindex(x,y,z,0,dim)] += ((Ny*tempVec[vindex(x,y,z,2,dim)]) - (Nz*tempVec[vindex(x,y,z,1,dim)])) * dt0;
		field[vindex(x,y,z,1,dim)] += ((Ny*tempVec[vindex(x,y,z,0,dim)]) - (Nz*tempVec[vindex(x,y,z,2,dim)])) * dt0 ;
		field[vindex(x,y,z,2,dim)] += ((Ny*tempVec[vindex(x,y,z,1,dim)]) - (Nz*tempVec[vindex(x,y,z,0,dim)])) * dt0;
	}
}

__kernel void vectorProjectionFirst(__global float *field, __global float *tempField, __global float *tempSecondField, const unsigned int dim, const float h) {
	unsigned int z = get_global_id(2);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(0);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		unsigned int i = index(x,y,z,dim);

		tempSecondField[i] = (-h) * ((field[vindex(x+1,y,z,0,dim)] - field[vindex(x-1,y,z,0,dim)]) +
									 (field[vindex(x,y+1,z,1,dim)] - field[vindex(x,y-1,z,1,dim)]) +
									 (field[vindex(x,y,z+1,2,dim)] - field[vindex(x,y,z-1,2,dim)])) / 3;
	}
}

__kernel void vectorProjectionSecond(__global float *field, __global float *tempField, __global float *tempSecondField, const unsigned int dim, const float h) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		tempField[index(x,y,z,dim)] = (tempSecondField[index(x,y,z,dim)] +
									   tempField[index(x-1,y,z,dim)] + tempField[index(x+1,y,z,dim)] +
									   tempField[index(x,y-1,z,dim)] + tempField[index(x,y+1,z,dim)] +
									   tempField[index(x,y,z-1,dim)] + tempField[index(x,y,z+1,dim)]) / 6;
	}
}

__kernel void vectorProjectionThird(__global float *field, __global float *tempField, __global float *tempSecondField, const unsigned int dim, const float h) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		field[vindex(x,y,z,0,dim)] -= (tempField[index(x+1,y,z,dim)] - tempField[index(x-1,y,z,dim)]) / 3 / h;
		field[vindex(x,y,z,1,dim)] -= (tempField[index(x,y+1,z,dim)] - tempField[index(x,y-1,z,dim)]) / 3 / h;
		field[vindex(x,y,z,2,dim)] -= (tempField[index(x,y,z+1,dim)] - tempField[index(x,y,z-1,dim)]) / 3 / h;
	}
}

__kernel void vectorDiffusion(__global float *field, __global float *tempField, const unsigned int dim, const float dt, const float viscosity) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		float a = dt * viscosity * dim * dim * dim;

		for(int d = 0; d < 3; d++) {
			field[vindex(x,y,z,d,dim)] = (tempField[vindex(x,y,z,d,dim)] +
										 a*(field[vindex(x-1,y,z,d,dim)] + field[vindex(x+1,y,z,d,dim)]
										  + field[vindex(x,y-1,z,d,dim)] + field[vindex(x,y+1,z,d,dim)]
										  + field[vindex(x,y,z-1,d,dim)] + field[vindex(x,y,z+1,d,dim)])) / (1+6*a);
		}
	}
}

static void clipPath(int x, int y, int z, float *xx, float *yy, float *zz, int dim) {
	float3 source = {x,y,z};
	float3 target = {(*xx),(*yy),(*zz)};
	float3 path = {(*xx)-x, (*yy)-y, (*zz)-z};
	float3 result;

	int tx, ty, tz;
	float len = 0;
	float rx, ry, rz;
	int dx, dy, dz;

	if((*xx) >= x) {
		dx = 1;
	}
	else {
		dx = -1;
	}

	if((*yy) >= y) {
		dy = 1;
	}
	else {
		dy = -1;
	}

	if((*zz) >= z) {
		dz = 1;
	}
	else {
		dz = -1;
	}

	float3 subpath = path;

	if(subpath.x != 0) {
		subpath /= (subpath.x * dx);

		result = source + (subpath * 0.5f);

		while((int)result.x*dx < (int)target.x*dx && (len == 0 || length(result-source) < len)) {
			tx = (int)result.x;
			ty = (int)result.y;
			tz = (int)result.z;

			if(dx > 0) {
				if(tx+1 == dim+1) {
					if(len == 0 || length(result-source) < len) {
						len = length(result-source);
						rx = result.x;
						ry = result.y;
						rz = result.z;
					}
					break;
				}
			}
			else {
				if(tx-1 == 0) {
					if(len == 0 || length(result-source) < len) {
						len = length(result-source);
						rx = result.x;
						ry = result.y;
						rz = result.z;
					}
					break;
				}
			}

			result += subpath;
		}
	}

	subpath = path;

	if(subpath.y != 0) {
		subpath /= (subpath.y * dy);

		result = source + (subpath * 0.5f);

		while((int)result.y*dy < (int)target.y*dy && (len == 0 || length(result-source) < len)) {
			tx = (int)result.x;
			ty = (int)result.y;
			tz = (int)result.z;

			if(dy > 0) {
				if(ty+1 == dim+1) {
					if(len == 0 || length(result-source) < len) {
						len = length(result-source);
						rx = result.x;
						ry = result.y;
						rz = result.z;
					}
					break;
				}
			}
			else {
				if(ty-1 == 0) {
					if(len == 0 || length(result-source) < len) {
						len = length(result-source);
						rx = result.x;
						ry = result.y;
						rz = result.z;
					}
					break;
				}
			}

			result += subpath;
		}
	}

	if(subpath.z != 0) {
		subpath /= (subpath.z * dz);

		result = source + (subpath * 0.5f);

		while((int)result.z*dz < (int)target.z*dz && (len == 0 || length(result-source) < len)) {
			tx = (int)result.x;
			ty = (int)result.y;
			tz = (int)result.z;

			if(dz > 0) {
				if(tz+1 == dim+1) {
					if(len == 0 || length(result-source) < len) {
						len = length(result-source);
						rx = result.x;
						ry = result.y;
						rz = result.z;
					}
					break;
				}
			}
			else {
				if(tz-1 == 0) {
					if(len == 0 || length(result-source) < len) {
						len = length(result-source);
						rx = result.x;
						ry = result.y;
						rz = result.z;
					}
					break;
				}
			}

			result += subpath;
		}
	}

	if(len != 0) {
		(*xx) = rx;
		(*yy) = ry;
		(*zz) = rz;
	}
}

__kernel void vectorAdvection(__global float *field, __global float *tempField, const unsigned int dim, const float dt) {
	unsigned int x = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int z = get_global_id(2);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		unsigned int i = vindex(x, y, z, 0, dim);
		unsigned int vx = vindex(x, y, z, 0, dim);
		unsigned int vy = vindex(x, y, z, 1, dim);
		unsigned int vz = vindex(x, y, z, 2, dim);

		int i0, j0, k0, i1, j1, k1;
		float sx0, sx1, sy0, sy1, sz0, sz1, v0, v1;
		float xx, yy, zz, dt0;

		dt0 = dt * dim;

		xx = x-(dt0*tempField[vx]);
		yy = y-(dt0*tempField[vy]);
		zz = z-(dt0*tempField[vz]);

		//TODO: check if this should be < 0
		if(xx < 1.5) {
			xx = 1.5;
		}

		if(yy < 1.5) {
			yy = 1.5;
		}

		if(zz < 1.5) {
			zz = 1.5;
		}

		if(xx > dim + 0.5) {
			xx = dim + 0.5;
		}

		if(yy > dim + 0.5) {
			yy = dim + 0.5;
		}

		if(zz > dim + 0.5) {
			zz = dim + 0.5;
		}

		clipPath(x, y, z, &xx, &yy, &zz, dim);

		i0 = (int)xx;
		i1 = i0+1;

		j0 = (int)yy;
		j1 = j0+1;

		k0 = (int)zz;
		k1 = k0+1;

		sx1 = xx -i0;
		sx0 = 1-sx1;

		sy1 = yy -j0;
		sy0 = 1-sy1;

		sz1 = zz -k0;
		sz0 = 1-sz1;

		for(int d = 0; d < 3; d++) {
			v0 = sx0 * (sy0 * tempField[vindex(i0,j0,k0,d,dim)] + sy1 * tempField[vindex(i0,j1,k0,d,dim)]) +
			 sx1 * (sy0 * tempField[vindex(i1,j0,k0,d,dim)] + sy1 * tempField[vindex(i1,j1,k0,d,dim)]);

			v1 = sx0 * (sy0 * tempField[vindex(i0,j0,k1,d,dim)] + sy1 * tempField[vindex(i0,j1,k1,d,dim)]) +
			 sx1 * (sy0 * tempField[vindex(i1,j0,k1,d,dim)] + sy1 * tempField[vindex(i1,j1,k1,d,dim)]);

			field[vindex(x, y, z, d, dim)] = sz0*v0 + sz1*v1;
		}
	}
}




// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
