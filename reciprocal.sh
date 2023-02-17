#!/bin/bash
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt

data="CIFAR10"
dir="data/"
model="resnet20_quan"
classes=10

# Train ResNet-20 models (8-bit) with output code matching on CIFAR-10
python -u main.py --data_dir $dir --dataset $data -c $classes --arch $model --bits 8 --outdir "results/cifar10/coe10/" -coe 10
python -u main.py --data_dir $dir --dataset $data -c $classes --arch $model --bits 8 --outdir "results/cifar10/coe100/" -coe 100

# Evaluate Stealthy T-BFA attacks on OCM defended models
python -u attack_tbfa.py --data_dir $dir --dataset $data -c $classes --arch $model --bits 8 --outdir "results/cifar10/coe10/"
python -u attack_tbfa.py --data_dir $dir --dataset $data -c $classes --arch $model --bits 8 --outdir "results/cifar10/coe100/"
