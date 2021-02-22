#!/bin/bash

source ${MODULESHOME}/init/bash
module purge
module load DefApps xl cuda parallel-netcdf cmake

export TEST_MPI_COMMAND="jsrun -n 1 -c 1 -a 1 -g 1"

./cmake_clean.sh

cmake -DCMAKE_CXX_COMPILER=mpic++ \
      -DPNETCDF_PATH=${OLCF_PARALLEL_NETCDF_ROOT}   \
      -DCXXFLAGS="-O3 -g -qsmp=omp -qoffload" \
      -DARCH="OPENMP45" \
      -DOPENMP45_FLAGS="" \
      -DNX=2000 \
      -DNZ=1000 \
      -DSIM_TIME=5 \
      ..

