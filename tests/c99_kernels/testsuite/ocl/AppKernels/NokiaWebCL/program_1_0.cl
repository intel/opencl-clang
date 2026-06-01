unsigned int index(unsigned int x, unsigned int y, unsigned int z, unsigned int dim) {
	return (x * (dim+2) * (dim+2)) + (y * (dim+2)) + z;
}

unsigned int vindex(unsigned int x, unsigned int y, unsigned int z, unsigned int d, unsigned int dim) {
	return (3 * index(x, y, z, dim)) + d;
}

float interpolate(__global float *field, float xx, float yy, float zz, unsigned int dim) {
	int i0, j0, k0, i1, j1, k1;
	float sx0, sx1, sy0, sy1, sz0, sz1, v0, v1;

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

	v0 = sx0 * (sy0 * field[index(i0,j0,k0,dim)] + sy1 * field[index(i0,j1,k0,dim)]) +
		 sx1 * (sy0 * field[index(i1,j0,k0,dim)] + sy1 * field[index(i1,j1,k0,dim)]);

	v1 = sx0 * (sy0 * field[index(i0,j0,k1,dim)] + sy1 * field[index(i0,j1,k1,dim)]) +
		 sx1 * (sy0 * field[index(i1,j0,k1,dim)] + sy1 * field[index(i1,j1,k1,dim)]);

	return sz0*v0 + sz1*v1;
}

float sampleLight(__global float *field, float xx, float yy, float zz, const int dim, const float ds) {
	float3 lightPos = {0, dim, 0};
	float3 target = {xx,yy,zz};

	float3 lightDir = lightPos - target;
	lightDir = normalize(lightDir) * ds;

	float sum = 0;

	while(target.y > dim) {
		sum += interpolate(field, target.x, target.y, target.z, dim);
		target += lightDir;
	}

	return exp(-ds * sum);
}


__kernel void volumeRayMarching(__global unsigned int *pixels, __global float *field, const int width, const int height, const float len, const float cubePos, const float cubeWidth, const int dim, const float ds) {
	int x = get_global_id(0);
	int y = get_global_id(1);

	if(x < width && y < height) {
		float3 vec = {x-(width/2),y-(height/2),len};
		float3 dir = normalize(vec);
		float4 sampleColor = {155.0f,55.0f,55.0f,0.0f};
		float4 finalColor = {0.0f, 0.0f, 0.0f, 0.0f};
		float4 bgColor = {255.0f, 255.0f, 255.0f, 0.0f};
		float T = 1.0f;
		const float kappa = 0.6f;
		float density, light, dT;

		vec = (dir/dir.z) * (cubePos - (cubeWidth / 2));

		if(vec.x > (-cubeWidth / 2) && vec.y > (-cubeWidth / 2) && vec.x < (cubeWidth / 2) && vec.y < (cubeWidth / 2)) {
			vec = (vec / cubeWidth) * dim;

			dir = normalize(vec);
			float3 svec = dir * ds;

			vec.x += (dim / 2);
			vec.y += (dim / 2);
			vec.z = 0.0;

			while(vec.x > 0 && vec.x < dim && vec.y > 0 && vec.y < dim && vec.z < dim) {
				density = interpolate(field, vec.x, vec.y, vec.z, dim);
				//light = 1.0f; //TODO
				light = sampleLight(field, vec.x, vec.y, vec.z, dim, ds);
				dT = exp(density * (-ds) * kappa);
				T *= dT;

				finalColor += (1.0f-dT) * T/kappa * sampleColor * light;

				vec += svec;
			}
			finalColor.w = (1.0-dT);
		}

		finalColor = (1-T)*finalColor + T*bgColor;
		pixels[(y*width) + x] = ((uchar)finalColor.w << 24) | ((uchar)finalColor.z << 16) | ((uchar)finalColor.y << 8) | (uchar)finalColor.x;
	}
}

__kernel void scalarAddField(__global float *field, __global float *srcField, const unsigned int dim, const float dt) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 2);

	if(x < lim && y < lim && z < lim) {
		unsigned int i = index(x, y, z, dim);
		field[i] += srcField[i] * dt;
	}
}

__kernel void scalarCopy(__global float *field, __global float *tempField, const unsigned int dim) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 2);

	if(x < lim && y < lim && z < lim) {
		unsigned int i = index(x, y, z, dim);

		tempField[i] = field[i];
	}
}

__kernel void scalarBoundaryDensities(__global float *field, const unsigned int dim) {
	unsigned int i = get_global_id(0);
	unsigned int j = get_global_id(1);

	unsigned int lim = (dim + 2);

	if(i < lim && j < lim && !((i == 0 && (j == 0 || j == lim-1)) || (i == lim-1 && (j == 0 || j == lim-1)))) {
		field[index(0, i, j, dim)] = field[index(1, i, j, dim)]; //left boundary
		field[index(dim+1, i, j, dim)] = field[index(dim, i, j, dim)]; //right boundary
		field[index(i, 0, j, dim)] = field[index(i, 1, j, dim)]; // bottom boundary
		field[index(i, dim+1, j, dim)] = field[index(i, dim, j, dim)]; // top boundary
		field[index(i, j, 0, dim)] = field[index(i, j, 1, dim)]; // back boundary
		field[index(i, j, dim+1, dim)] = field[index(i, j, dim, dim)]; // top boundary
	}

	// Corner densities
	if(i == 0 && j == 0) {
		field[index(0,0,0,dim)] = (field[index(1,0,0,dim)] + field[index(0,1,0,dim)] + field[index(0,0,1,dim)]) / 3;
		field[index(0,dim+1,0,dim)] = (field[index(1,dim+1,0,dim)] + field[index(0,dim,0,dim)] + field[index(0,dim+1,1,dim)]) / 3;
		field[index(dim+1,0,0,dim)] = (field[index(dim,0,0,dim)] + field[index(dim+1,1,0,dim)] + field[index(dim+1,0,1,dim)]) / 3;
		field[index(dim+1,dim+1,0,dim)] = (field[index(dim,dim+1,0,dim)] + field[index(dim+1,dim,0,dim)] + field[index(dim+1,dim+1,1,dim)]) / 3;
		field[index(0,0,dim+1,dim)] = (field[index(1,0,dim+1,dim)] + field[index(0,1,dim+1,dim)] + field[index(0,0,dim,dim)]) / 3;
		field[index(0,dim+1,dim+1,dim)] = (field[index(1,dim+1,dim+1,dim)] + field[index(0,dim,dim+1,dim)] + field[index(0,dim+1,dim,dim)]) / 3;
		field[index(dim+1,0,dim+1,dim)] = (field[index(dim,0,dim+1,dim)] + field[index(dim+1,1,dim+1,dim)] + field[index(dim+1,0,dim,dim)]) / 3;
		field[index(dim+1,dim+1,dim+1,dim)] = (field[index(dim,dim+1,dim+1,dim)] + field[index(dim+1,dim,dim+1,dim)] + field[index(dim+1,dim+1,dim,dim)]) / 3;
	}
}

__kernel void scalarDiffusion(__global float *field, __global float *tempField, const unsigned int dim, const float dt, const float viscosity) {
	unsigned int z = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int x = get_global_id(2);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		float a = dt * viscosity * dim * dim * dim;
		unsigned int i = index(x, y, z, dim);

		field[i] = (tempField[i] + a*(field[index(x-1,y,z,dim)] + field[index(x+1,y,z,dim)] +
									  field[index(x,y-1,z,dim)] + field[index(x,y+1,z,dim)] +
									  field[index(x,y,z-1,dim)] + field[index(x,y,z+1,dim)])) / (1+6*a);
	}
}

void clipPath(int x, int y, int z, float *xx, float *yy, float *zz, int dim) {
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

__kernel void scalarAdvection(__global float *field, __global float *tempField, __global float *velocityField, const unsigned int dim, const float dt) {
	unsigned int x = get_global_id(0);
	unsigned int y = get_global_id(1);
	unsigned int z = get_global_id(2);

	unsigned int lim = (dim + 1);

	if(x > 0 && x < lim && y > 0 && y < lim && z > 0 && z < lim) {
		unsigned int i = index(x, y, z, dim);
		unsigned int vx = vindex(x, y, z, 0, dim);
		unsigned int vy = vindex(x, y, z, 1, dim);
		unsigned int vz = vindex(x, y, z, 2, dim);

		int i0, j0, k0, i1, j1, k1;
		float sx0, sx1, sy0, sy1, sz0, sz1, v0, v1;
		float xx, yy, zz, dt0;

		dt0 = dt * dim;

		xx = x-(dt0*velocityField[vx]);
		yy = y-(dt0*velocityField[vy]);
		zz = z-(dt0*velocityField[vz]);

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

		v0 = sx0 * (sy0 * tempField[index(i0,j0,k0,dim)] + sy1 * tempField[index(i0,j1,k0,dim)]) +
			 sx1 * (sy0 * tempField[index(i1,j0,k0,dim)] + sy1 * tempField[index(i1,j1,k0,dim)]);

		v1 = sx0 * (sy0 * tempField[index(i0,j0,k1,dim)] + sy1 * tempField[index(i0,j1,k1,dim)]) +
			 sx1 * (sy0 * tempField[index(i1,j0,k1,dim)] + sy1 * tempField[index(i1,j1,k1,dim)]);

		field[i] = sz0*v0 + sz1*v1;
	}
}



// buildOptions=
// RUN: %occ-cli %s --cl-options="-I%cwd -I%S " %cfg_path --cl-device=%cl_device 2>&1
