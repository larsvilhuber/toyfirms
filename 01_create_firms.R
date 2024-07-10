# Translation by Claude Sonnet 3.5
# Edits by Lars Vilhuber

# Basic parameters
indcnt <- 100
maxestabcnt <- 10000
minestabcnt <- 100
seed1 <- 123456

maxemp <- 42000
minemp <- 1
seed2 <- 1234567

# Set seeds for reproducibility
set.seed(seed1)

# Draw establishment count distribution across industries
# Use log normal distribution
industries <- data.frame(
  industry = 1:indcnt,
  estabs = exp(runif(indcnt) * (log(maxestabcnt) - log(minestabcnt)) + log(minestabcnt))
)

# Summary statistics for estabs
summary(industries$estabs)
hist(industries$estabs, main="Distribution of Establishments", xlab="Number of Establishments")

# Now draw employment for each establishment in each industry
set.seed(seed2)

fakelbd <- do.call(rbind, lapply(1:nrow(industries), function(i) {
  data.frame(
    industry = industries$industry[i],
    emp = exp(runif(industries$estabs[i]) * (log(maxemp) - log(minemp)) + log(minemp))
  )
}))

# Summary statistics for emp
summary(fakelbd$emp)
hist(fakelbd$emp, main="Distribution of Employment", xlab="Number of Employees")