#!/bin/bash

# стандартный запуск pipeline'а
nextflow run pipeline.nf

# в процессе запуска результат процессов кешируется и при помощи флага resume можно использовать
# закешированные данные для более быстрого процесса отработки pipeline'а
nextflow run pipeline.nf -resume

# также можно передавать параметры через --paramName "sampleText"
# можно задать значение для параметра params.paramName = 'Hello world!'

# то же самое, но с визуализацией работы пайплайна
nextflow run -resume pipeline.nf -with-dag diagram.png