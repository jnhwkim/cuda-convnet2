import pickle as pkl
import pprint
import numpy as np

# get pred
numBatches = 5
epochs = 100
probs = np.zeros((10000, 10))
for Idx in range(numBatches):
    f = open("/opt2/cifar-10-py-colmajor/tmp/npe_cifar10_t"+str(epochs)+"_"+str(Idx+1)+"/test_preds_6")
    d = pkl.load(f)
    probs = probs + d["data"]
probs = probs / numBatches
pred = np.argmax(probs, axis=1)

# get labels
f = open("/opt2/cifar-10-py-colmajor/data_batch_6")
d = pkl.load(f)
labels = d["labels"]

# print accuracy
correct = [i for i, j in zip(labels, pred) if i == j]
print "%f"%(1-len(correct)/10000.)
