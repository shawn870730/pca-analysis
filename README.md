### README.md

# Financial Econometrics Analysis

The analysis is performed using MATLAB, and it involves PCA (Principal Component Analysis) and MLE (Maximum Likelihood Estimation) Factor Analysis on a selected set of stock price series.

## Problem Description

### Problem 1: PCA Analysis
1. **Data Selection**: Select a set of at least ten stock price series, download, transform to returns, and standardize each to mean zero and variance one.
2. **Principal Components Calculation**: Calculate the first two principal components and report the coefficient estimates.
3. **Variance Explanation**: Determine the percentage of variance explained by the first and the first two principal components.

### Problem 2: MLE Factor Analysis
1. **Factor Model Estimation**: Using the same stock price series, estimate a 2-factor model by MLE.
2. **Reporting**: Report the coefficients and variance estimates.

### Data Processing

- **PCA Analysis**: The script calculates the returns from the downloaded stock prices, standardizes them, and performs PCA to extract the first two principal components.
- **MLE Factor Analysis**: The script uses the standardized returns to estimate a 2-factor model using MLE.

### Output

- **PCA Coefficients and Variance**: The script will output the coefficient estimates for the first two principal components and the percentage of variance explained by these components.
- **MLE Estimates**: The script will provide the factor loadings and variance estimates for the 2-factor model.

## Results Interpretation

- **PCA Analysis**: The first principal component usually captures the maximum variance in the data, and the second component captures the next highest variance orthogonally to the first. The results will show how much of the total variance is captured by these two components.
- **MLE Factor Analysis**: The factor loadings indicate how much each stock contributes to the underlying factors, and the variance estimates provide insights into the variability captured by these factors.
