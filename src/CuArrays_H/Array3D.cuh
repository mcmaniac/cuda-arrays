#pragma once

#include "Array2D.cuh"

namespace CuArrays
{

template <typename T> class ManagedArray3D;

/*
 * 3D arrays
 *
 */

template <typename T>
class Array3D
{
    friend class ManagedArray3D<T>;

    private:

        Array2D<T> array2d;

        int _N, _M, _O;

        __host__ Array3D(Array2D<T>, int N, int M, int O);

    public:

        __device__ __host__ Array3D();

        __device__ int N() const;
        __device__ int M() const;
        __device__ int O() const;

        __device__ T& get(unsigned int i, unsigned int j, unsigned int k);
        __device__ const T& get(unsigned int i, unsigned int j, unsigned int k) const;

        __device__ T& operator()(unsigned int i, unsigned int j, unsigned int k);
        __device__ const T& operator()(unsigned int i, unsigned int j, unsigned int k) const;
};

/*
 * Implementations
 *
 */


template <typename T>
__host__
Array3D<T>::Array3D(Array2D<T> arr2d, int N, int M, int O)
    : array2d(arr2d)
    , _N(N)
    , _M(M)
    , _O(O)
{
}

template <typename T>
__device__ __host__
Array3D<T>::Array3D()
{
}

template <typename T>
__device__
int Array3D<T>::N() const
{
    return _N;
}
template <typename T>
__device__
int Array3D<T>::M() const
{
    return _M;
}
template <typename T>
__device__
int Array3D<T>::O() const
{
    return _O;
}

template <typename T>
__device__
T& Array3D<T>::get(unsigned int i, unsigned int j, unsigned int k)
{
    return array2d.get(i, _M * j + k);
}

template <typename T>
__device__
const T& Array3D<T>::get(unsigned int i, unsigned int j, unsigned int k) const
{
    return array2d.get(i, _M * j + k);
}

template <typename T>
__device__
T& Array3D<T>::operator()(unsigned int i, unsigned int j, unsigned int k)
{
    return get(i,j,k);
}

template <typename T>
__device__
const T& Array3D<T>::operator()(unsigned int i, unsigned int j, unsigned int k) const
{
    return get(i,j,k);
}

}