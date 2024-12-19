# README

## Preparation

Network is required for this section.

```shell
pip install -r requirements.txt
```

### **HuggingFace Login**

Install the HuggingFace CLI:

```shell
pip install huggingface_hub
```

Authenticate:

```shell
huggingface-cli login
[authenticate token]
```

### **Download Models**

Start model download to the `model` directory:

```shell
python 01_download_models.py --model-path model &
```

## Experiment

### **Model Directory Check**

Verify that each model directory contains a `config.json` file. Use the automated check script:

```shell
./02_check_model_path.sh
```

**Note**: If the `config.json` file is under a snapshot directory, adjust the path (model_names) in `1_longeval_lines.sh` like this:

Example:
 `model/meta-llama_Llama-3.2-3B-Instruct/snapshots/<snapshot_id>`

Replace:
 `meta-llama_Llama-3.2-3B-Instruct`
with
 `meta-llama_Llama-3.2-3B-Instruct/snapshots/<snapshot_id>`

### **LongEval**

Update `max_gpu_memory` and `num_gpus` settings in `1_longeval_lines.sh` for GPU setup.
Example for 4 A100 GPUs (each 80GB):

**Script `1_longeval_lines.sh`:**

```shell
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
            --test_dir "longeval/evaluation" \
            --task lines \
            --max_gpu_memory 80 \
            --num_gpus 2 &
        wait
    done
done
```

Test with only one model one iteration:

```shell
python longeval/eval.py \
    --model-name-or-path "model/HanzhiZhang_DAM_0.99" \
    --count "1" \
    --test_dir "longeval/evaluation" \
    --task lines \
    --max_gpu_memory 80 \
    --num_gpus 2 &
```

Process script to automated looping all models for 10 times:

```shell
./1_longeval_lines.sh &
```

