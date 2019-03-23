# Implementation of methods employed and datasets used in Hartoyo et al. (2019)
To examine the identifiability and sloppiness of the neural population model, we fit it to an EEG spectrum and estimate the posterior distribution over the 22 unknown parameters. We then characterize the properties of this distribution to diagnose the signatures of unidentifiability and sloppiness. To ensure that our results are not specific to a particular fitting algorithm, we use two independent methods: particle swarm optimization (PSO) and Markov chain Monte Carlo (MCMC). To ensure that our results are not specific to a given individual, we estimate the 22 posterior distributions, using both methods, for each of the 82 different EEG spectra. We then outline the two fitting schemes, focusing on how we use them to sample from the 22-dimensional posterior distribution. Finally, we describe use of the Kullback-Leibler divergence (KLD) to summarize how much we learned about individual parameters, and the Fisher information matrix (FIM), to assess the sloppiness and identifiability of the model. A full description of the techniques is described in the following manuscript:

"<b>Parameter estimation and identifiability in a neural population model for electro-cortical activity</b>" by Agus Hartoyo, Peter Cadusch, David Liley, and Damien Hicks, doi: https://doi.org/10.1101/492504 

## Datasets

The "Hartoyo et al. (2019) datasets" folder contains the main and the most important datasets used and generated in Hartoyo et al. (2019)

```
82x73_target_spectra.mat : dataset of the 82 experimental spectra we fit the neural population model to
```

```
82_subject_indices.mat : mapping between indices and labels of the 82 selected subjects
```

```
82x100x22_best_paramsets_PSO.mat : dataset of the 10% best parameter sets selected from 1000 PSO samples
```

```
82x1000x22_best_paramsets_MCMC.mat : dataset of 1000 parameter sets sub-sampled from a million MCMC samples
```

#### The order of the 22 physiological parameteres: <br>
<p><img src="http://latex.codecogs.com/gif.latex?$\tau _{e}, \tau _{i}, \gamma _{e}, \gamma _{i}, \Gamma _{e}, \Gamma _{i}, N_{ee}^{\beta }, N_{ei}^{\beta }, N_{ie}^{\beta }, N_{ii}^{\beta }, p_{ee}, p_{ei}, h_{e}^{rest}, h_{i}^{rest}, h_{e}^{eq}, h_{i}^{eq}, S_{e}^{\max }, S_{i}^{\max }, \bar{\mu _{e}}, \bar{\mu _{i}}, {\sigma }_{e}, {\sigma }_{i}$" border="0" /></p>


## Code

The "Hartoyo et al. (2019) code" folder is a Matlab<sup>&reg;</sup> source code folder that provides implementation code along with supporting data required to reproduce the experimental results presented in Hartoyo et al. (2019).

### Setup
1.	Clone or download this repository 
2.	Access the "Hartoyo et al. (2019) code" folder using Matlab<sup>&reg;</sup>
3. Run methods and reproduce results/visualizations by executing the following Matlab<sup>&reg;</sup> commands

### Run PSO-based random sampling
```
RunPSObasedSampling;
```

### Run MCMC sampling
```
BaseSetup;
```
```
RunSequenceBase(S_c(indx_a,indx_f),freq(indx_f),prm,dev_a,psel,mparam);
```

### Plot figures
```
FigureSetup;
```
```
FiguresBase(fparam, [figtype]);
``` 

#### Input arguments:
   figtype = 1 -> spectral fits for selected subjects (default) <br>
   figtype = 2 -> single subject post and prior MCMC distributions <br>
   figtype = 3 -> KLD Box plots for all subjects <br>
   figtype = 4 -> parameter box plots for all subjects <br>
   figtype = 5 -> Hessian eigenvalues (selected subjects) <br>
   figtype = 6 -> Fisher Information eigenvalues (selected subjects) <br>
   figtype = 7 -> Hessian eigenvector kernel smoothed density plots (all subjects) <br>
   figtype = 8 -> Fisher matrix eigenvector angle density plots (all subjects) <br>
   figtype = 9 -> plot prior distributions of Eigen-directions <br>
   figtype = 10 -> plot fitted spectra and spectra at points shifted in eigen directions <br>
   figtype = 11 -> plot the time domain eeg comparisons <br>
   figtype = 12 -> plot pairwise parameter histograms <br>
   figtype = 13 -> plot eigenvector components <br>
   figtype = 14 -> plot of derivatives of gaussain wrt its parameters <br>
   figtype = 15 -> plot of direction cosine magnitudes <br>
   figtype = 16 -> plot correlation coefficients <br>






