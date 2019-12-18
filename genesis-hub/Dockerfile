FROM jupyterhub/k8s-hub:0.9.0-alpha.1.090.1810aa5

USER root

# Customize the logo
COPY dirac-jupyter-logo.png /usr/local/share/jupyterhub/static/images/jupyterhub-80.png

USER ${NB_USER}
