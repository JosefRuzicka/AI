//
// Created by Charlie Solorzano  on 12/5/22.
//

#ifndef NEURALNETWORK_MATRIX_HPP
#define NEURALNETWORK_MATRIX_HPP
#include <vector>
#include <string>

using namespace std;

class Matrix
{
public:
  vector<vector<double>> data;
  int rows;
  int columns;

  Matrix(int i, int j);

  Matrix();

  virtual ~Matrix();

  void printMatrix();
  void sigmoid();
  void addScalar(double scalar);
  void addMatrix(Matrix &matrix);
  static Matrix matrixSubstract(Matrix &m1, Matrix &m2);
  void multiply(Matrix &a);
  void multiply(double scalar);
  static Matrix transpose(Matrix &a);
  static Matrix multiply(Matrix &a, Matrix &b);
  static Matrix fromArray(vector<double> values);
  vector<double> toArray();
  string toString();
  Matrix dsigmoid();

private:
};

#endif // NEURALNETWORK_MATRIX_HPP
