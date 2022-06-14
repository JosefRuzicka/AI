//
// Created by Josef Ruzicka 2022.
//

#ifndef NEURALNETWORK_NEURALNETWORK_HPP
#define NEURALNETWORK_NEURALNETWORK_HPP

#include "Matrix.hpp"
#include <vector>

class NeuralNetwork
{
public:
    vector<int> neuronCountPerLayer;
    vector<Matrix> biases;
    vector<Matrix> weights;
    vector<Matrix> layerOutputs;
    double learningRate;

    NeuralNetwork(vector<int> neuronCountPerLayer);
    virtual ~NeuralNetwork();
    vector<double> predict(vector<double> values);
    void train(vector<double> values, vector<double> expectedValues);
    void fit(vector<vector<double>> values, vector<vector<double>> expectedValues, int epochs);
};

#endif // NEURALNETWORK_NEURALNETWORK_HPP
