#!/bin/bash

model_names=(
    "HanzhiZhang_H2O-llama-model"
    "HanzhiZhang_StreamingLLM-llama-model"
    "HanzhiZhang_MoA-llama-model"
    "HanzhiZhang_DAM_0.99"
    "meta-llama_Llama-3.2-3B-Instruct"
)

for model_name in "${model_names[@]}"; do
    for ite in {1..10}; do
        python longeval/eval.py \
            --model-name-or-path "model/$model_name" \
            --count "$ite" \
            --task lines \
            --max_gpu_memory 80 \
            --num_gpus 2 &
        wait
    done
done