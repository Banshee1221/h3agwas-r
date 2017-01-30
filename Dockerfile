FROM ubuntu:latest

MAINTAINER Eugene de Beste

RUN apt-get update -y && \
    apt-get install --no-install-recommends r-base-core -y && \
    apt-get install -y  \
        build-essential \
        wget \
        zlib1g-dev \
        libblas-dev \
        liblapack-dev \
        gfortran \
        libssl-dev \
        libnetcdf-dev \
        netcdf-bin \
        r-cran-kernsmooth

RUN touch script.R
RUN printf "source('https://bioconductor.org/biocLite.R')\nbiocLite('crlmm')\n" >> script.R
RUN printf "source('https://bioconductor.org/biocLite.R')\nbiocLite('GWASTools')\n" >> script.R
RUN printf "source('https://bioconductor.org/biocLite.R')\nbiocLite('hapmap370k')" >> script.R
RUN printf "install.packages('ff', 'bit', dependencies=TRUE, repos='http://cran.rstudio.com/')" >> script.T
RUN Rscript script.R
RUN rm script.R
RUN printf 'options(defaultPackages=c(getOption("defaultPackages"), "crlmm", "GWASTools", "ff", "bit"))\n' >> /etc/R/Rprofile.site
