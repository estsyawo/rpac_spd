% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Functions_Cross_Dep.R
\name{reg_cdir}
\alias{reg_cdir}
\title{Cross-sectional dependence in regression}
\usage{
reg_cdir(startdel, Y, X, Xm, ..., modclass = "lmcd", rvcov = FALSE)
}
\arguments{
\item{startdel}{vector of starting values for \strong{\eqn{\delta}}}

\item{Y}{outcome variable}

\item{X}{matrix of covariates or design matrix}

\item{Xm}{matrix of other control variables}

\item{...}{other arguments to be passed to \link{ncd_gen} \strong{except} arguments listed here and \code{rval}.
Argument names must match exactly.}

\item{modclass}{the class of model. See description above for classes supported.}

\item{rvcov}{Logical. Should the variance-covariance matrix be returned?}
}
\value{
A list
\itemize{
  \item coefs vector of coefficients
  \item stde vector of standard errors
  \item tstat vector of t-statistics
  \item pval vector of p-values
  \item varcov variance-covariance matrix if \code{rvcov} is set to \code{TRUE}
  \item Wstat a Wald chi-square statistic
  \item pvwald Prob>Wstat 
}
}
\description{
A routine like \code{reg_cd()} that partially optimises with respect \strong{\eqn{\delta}} and 
uses internal R routines to optimise with respect to \strong{\eqn{\beta}}. This is particularly
helpful in high dimensional settings.
}
\examples{
pars = c(1.0,0.5,0.8); pars2=pars = c(1.0,0.5,0.8,0.1,-0.1); N = 10; Tp = 16 
fnp<- function(x,y,k) {-(0.5*y^4 + (x-y)^4)^.25} # a dummy k
datpois = gdat_cd(pars=pars,N=N,Tp=Tp,seed=2,fun=fnp,eta = 200,modclass="poiscd") 
datpois2 = gdat_cd(pars=pars2,N=N,Tp=Tp,ncXm=2,seed=2,fun=fnp,eta = 200,modclass="poiscd")
k=1; lp=k*(k+1)/2; startp = rep(0.2,lp); # fun() is known
zg1=RpacSPD::reg_cdir(startdel=startp,Y=datpois$Y,X=datpois$X,Xm=NULL,Xi=datpois$X,Tid=datpois$tpID,
Pid=datpois$psID,fun=fnp,k=k,nt=lp,utid=c(2:Tp),modclass="poiscd",rvcov=TRUE) #return function value
BIC(zg1) #compute BIC of fitted model

k=4; lp=k*(k+1)/2; startp = rep(0,lp); # fun() is polynomial approximated
zg4=RpacSPD::reg_cdir(startdel=startp,Y=datpois2$Y,X=datpois2$X,Xm=datpois2[c("X1","X2")],
Xi=datpois2$X,Tid=datpois2$tpID,Pid=datpois2$psID,fun=polyexp,k=k,nt=lp,utid=c(2:Tp),
modclass="poiscd",rvcov=TRUE)
BIC(zg4) #compute BIC of fitted model

}
\seealso{
\link{ncd_gen}, \link{reg_cd}
}
