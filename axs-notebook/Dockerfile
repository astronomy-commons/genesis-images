FROM jupyter/base-notebook

# Add RUN statements to install packages as the $NB_USER defined in the base images.

# Add a "USER root" statement followed by RUN statements to install system packages using apt-get,
# change file permissions, etc.

# If you do switch to root, always be sure to add a "USER $NB_USER" command at the end of the
# file to ensure the image runs as a unprivileged user by default.

USER root

# Install Java
RUN apt-get -y update && \
    apt-get install --no-install-recommends -y openjdk-8-jre-headless ca-certificates-java && \
    rm -rf /var/lib/apt/lists/*

# Copy start up scripts
COPY scripts/start-spark.sh /usr/local/bin/
COPY scripts/entrypoint.sh /usr/local/bin/
COPY scripts/pre-start-source.sh /usr/local/bin/
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

# Install AXS
ARG AXS_VERSION=v1.0
ENV AXS_URL=https://github.com/astronomy-commons/axs/releases/download/$AXS_VERSION/axs-distribution.tar.gz
ENV AXS_HOME=/opt/axs

RUN cd /tmp && \
    wget -q -O axs-distribution.tar.gz $AXS_URL && \
    mkdir $AXS_HOME && \
    tar xf axs-distribution.tar.gz --strip 1 -C $AXS_HOME && \
    rm axs-distribution.tar.gz && \
    chown -R $NB_UID:$NB_GID $AXS_HOME && \
    rm -f /home/$NB_USER/.wget-hsts
# Update environment variables
ENV SPARK_HOME $AXS_HOME
ENV PATH $PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

RUN $AXS_HOME/bin/axs-init-config.sh

USER $NB_UID

# Install pyarrow, numpy, pandas
RUN conda install --quiet --yes \
    'pyarrow' \
    'numpy' \
    'pandas' && \
    conda clean --all -f -y && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

