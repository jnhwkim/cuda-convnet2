#!/bin/bash
EPOCHS=100
for Idx in {1..5}
do
OPTIONS="--data-provider cifar --test-range 6 --train-range ${Idx} --data-path /opt2/cifar-10-py-colmajor --inner-size 24 --save-file /opt2/cifar-10-py-colmajor/tmp/npe_cifar10_e${EPOCHS}_${Idx} --gpu 0 --layer-def layers/layers-cifar10-11pct.cfg --layer-params layers/layer-params-cifar10-11pct.cfg --epochs $(($EPOCHS*$Idx)) --force-save 1 --test-freq ${EPOCHS}"
TEST_OP="--multiview-test 1 --test-out /opt2/cifar-10-py-colmajor/tmp/npe_cifar10_t${EPOCHS}_${Idx} --logreg-name logprob"
	if [ $Idx == 1 ]
	then
		python convnet.py $OPTIONS $TEST_OP
	else
		python convnet.py $OPTIONS --load-file /opt2/cifar-10-py-colmajor/tmp/npe_cifar10_e${EPOCHS}_$(($Idx-1)) $TEST_OP
	fi
done
