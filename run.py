from network import Network
from mnist_loader import load_data_wrapper


if __name__ == "__main__":
    training, validation, test = load_data_wrapper()
    net = Network([784, 100, 10])
    net.SGD(training, 30, 10, 3.0, test_data=test)
