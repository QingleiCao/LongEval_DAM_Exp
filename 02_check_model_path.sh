#!/bin/bash

# Define the array of model names
model_names=(
    "model/HanzhiZhang_H2O-llama-model"
    "model/HanzhiZhang_StreamingLLM-llama-model"
    "model/HanzhiZhang_MoA-llama-model"
    "model/HanzhiZhang_DAM_0.99"
    "model/meta-llama_Llama-3.2-3B-Instruct"
)

# Iterate over each model and check for config.json
for model in "${model_names[@]}"; do
    if [ -d "$model" ]; then
        if [ -f "$model/config.json" ]; then
            echo "✔️ config.json exists in '$model'."
        else
            echo "❌ config.json is missing in '$model'."
        fi
    else
        echo "❌ Directory '$model' does not exist."
    fi
done


