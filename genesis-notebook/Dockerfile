FROM jupyter/datascience-notebook:1386e2046833

#######################################################
# Packages installed as root
#######################################################
USER root

# General (editors, etc)
RUN sudo apt-get update && sudo apt-get install --yes telnet inetutils-ping
RUN sudo apt-get update && sudo apt-get install --yes openssh-client
RUN sudo apt-get update && sudo apt-get install --yes vim joe emacs-nox

# Alert Streaming
RUN curl -L http://research.majuric.org/other/kt -o /usr/local/bin/kt && chmod +x /usr/local/bin/kt
RUN curl -L http://research.majuric.org/other/kafkacat -o /usr/local/bin/kafkacat && chmod +x /usr/local/bin/kt

#######################################################
# Packages installed as joyvan (who owns conda)
#######################################################
USER $NB_UID

# notebook environment and utilities
RUN conda install -c defaults nb_conda_kernels
RUN conda install -c defaults -c conda-forge nbgitpuller

# install additional general data science and astronomy conda packages
RUN conda install -c defaults -c conda-forge munch tqdm pv
RUN conda install -c defaults -c conda-forge astropy aplpy astroml

# Alert Streaming
RUN conda install -c defaults -c conda-forge python-confluent-kafka fastavro python-avro

# Solar system
RUN conda install -c defaults -c conda-forge openorb

# Hide system kernels from nb_conda_kernels
# Place user-defined conda environments into the user's directory
RUN printf '\
\n\
c.CondaKernelSpecManager.env_filter = r"^/opt/.*$" \n\
c.CondaKernelSpecManager.name_format = "Conda env '"{1}"' ({0})" \n'\
>> /etc/jupyter/jupyter_notebook_config.py

RUN printf '\
envs_dirs:\n\
  - $HOME/.conda-envs\n\
' >> /opt/conda/.condarc
