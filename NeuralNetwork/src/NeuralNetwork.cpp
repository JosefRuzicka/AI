#include <iostream>
#include "NeuralNetwork.hpp"
#include <random>

using namespace std;

NeuralNetwork::NeuralNetwork(vector<int> neuronCountPerLayer)
{

  this->learningRate = 0.1;
  this->weights.resize(neuronCountPerLayer.size() + 1);
  this->biases.resize(neuronCountPerLayer.size() + 1);
  this->neuronCountPerLayer = neuronCountPerLayer;
  this->layerOutputs.resize(neuronCountPerLayer.size() + 1);
}

NeuralNetwork::~NeuralNetwork()
{
}

vector<double> NeuralNetwork::predict(vector<double> values)
{
  Matrix inputForLayer = Matrix::fromArray(values);
  Matrix networkOutput;
  // Forward propagation
  Matrix tempResults;
  for (int indexPeso = 0; indexPeso < this->weights.size(); indexPeso++)
  {
    tempResults = Matrix::multiply(this->weights[indexPeso], inputForLayer);
    tempResults.addMatrix(this->biases[indexPeso]);
    tempResults.sigmoid();
    inputForLayer = tempResults;
  }
  return inputForLayer.toArray();
}

void NeuralNetwork::train(vector<double> entrada, vector<double> expectedOutputValue)
{
  Matrix input = Matrix::fromArray(entrada);
  Matrix inputForLayer;
  Matrix target = Matrix::fromArray(expectedOutputValue);
  Matrix error;
  Matrix gradient;
  Matrix networkOutput;
  int inputCount = int(entrada.size());

  // Training.
  inputForLayer = Matrix::fromArray(entrada);
  Matrix tempResults;
  // Forward propagation
  for (int indexPeso = 0; indexPeso < this->weights.size(); indexPeso++)
  {
    tempResults = Matrix::multiply(this->weights[indexPeso], inputForLayer);
    tempResults.addMatrix(biases[indexPeso]);
    tempResults.sigmoid();
    this->layerOutputs[indexPeso] = tempResults;
    inputForLayer = tempResults;
  }
  networkOutput = inputForLayer;

  // Calculate error and gradient of NN output
  error = Matrix::matrixSubstract(target, networkOutput /* Epoch Output */);
  gradient = networkOutput.dsigmoid();
  gradient.multiply(error);
  gradient.multiply(this->learningRate);

  // Modify last weights and biases set
  Matrix previousLayerOutputTransposed = Matrix::transpose(layerOutputs[this->weights.size() - 2]);
  Matrix weightsPreviousLayerOutputDelta = Matrix::multiply(gradient, previousLayerOutputTransposed);
  this->weights[this->weights.size() - 1].addMatrix(weightsPreviousLayerOutputDelta);
  this->biases[this->biases.size() - 1].addMatrix(gradient);

  Matrix weightsNextLayer = weights[this->weights.size() - 1];
  Matrix weightsNextLayerTransposed;
  Matrix hiddenLayerErrors;
  Matrix nextHiddenLayerErrors = error;
  Matrix weightsPreviousLayerDelta;

  // Backpropagation
  for (int layerIndex = this->weights.size() - 2; layerIndex > 0; layerIndex--)
  {
        // Calculate new error and gradient for current weights set
        weightsNextLayerTransposed = Matrix::transpose(weightsNextLayer);
        hiddenLayerErrors = Matrix::multiply(weightsNextLayerTransposed, nextHiddenLayerErrors /*error*/);
        Matrix layerGradient = layerOutputs[layerIndex].dsigmoid();

        // Adjust current weights and biases set values
        layerGradient.multiply(hiddenLayerErrors);
        layerGradient.multiply(this->learningRate);
        previousLayerOutputTransposed = Matrix::transpose(layerOutputs[layerIndex - 1]);
        weightsPreviousLayerDelta = Matrix::multiply(layerGradient, previousLayerOutputTransposed);
        this->weights[layerIndex].addMatrix(weightsPreviousLayerDelta);
        this->biases[layerIndex].addMatrix(layerGradient);

        weightsNextLayer = weights[layerIndex];
        nextHiddenLayerErrors = hiddenLayerErrors;
  }

  // Error and gradient of first weights and biases set
  weightsNextLayerTransposed = Matrix::transpose(weightsNextLayer);
  hiddenLayerErrors = Matrix::multiply(weightsNextLayerTransposed, nextHiddenLayerErrors);
  Matrix layerGradient = layerOutputs[0].dsigmoid();

  // Adjust weights and biases
  layerGradient.multiply(hiddenLayerErrors); /*weightsNextLayerTransposed*/
  layerGradient.multiply(this->learningRate);
  previousLayerOutputTransposed = Matrix::transpose(input);
  weightsPreviousLayerDelta = Matrix::multiply(layerGradient, previousLayerOutputTransposed);
  weights[0].addMatrix(weightsPreviousLayerDelta);
  biases[0].addMatrix(layerGradient);
}

void NeuralNetwork::fit(vector<vector<double>> values, vector<vector<double>> expectedValues, int epochs)
{
  int outputLayer = 1;
  int inputCount = int(values[0].size());

  for (int indexCapa = 0; indexCapa < this->weights.size() - 1; indexCapa++)
  {
    this->weights[indexCapa] = (Matrix(this->neuronCountPerLayer[indexCapa], inputCount));
    this->biases[indexCapa] = (Matrix(this->neuronCountPerLayer[indexCapa], 1));
    inputCount = this->neuronCountPerLayer[indexCapa];
  }
  this->weights[this->weights.size() - 1] = (Matrix(outputLayer, neuronCountPerLayer[neuronCountPerLayer.size() - 1]));
  this->biases[this->biases.size() - 1] = Matrix(1, 1);

  std::default_random_engine generator;
  std::uniform_int_distribution<int> distribution(0, values.size() - 1);
  for (int epoch = 0; epoch < epochs; epoch++)
  {
    for (size_t valueIndex = 0; valueIndex < values.size(); valueIndex++)
    //{
    //  this->trainNuevo(values[valueIndex], expectedValues[valueIndex]);
   // }
    // cout << "Epoch " << epoch << " Completed" << endl;
    int sampleN;
    int sampleN = distribution(generator);
    this->train(values[sampleN], expectedValues[sampleN]);
  }
}
