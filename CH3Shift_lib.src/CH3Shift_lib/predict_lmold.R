# From R 2.11.1

#  File src/library/stats/R/lm.R
#  Part of the R package, http://www.R-project.org
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  A copy of the GNU General Public License is available at
#  http://www.r-project.org/Licenses/



## code originally from John Maindonald 26Jul2000
predict.lmold <-
    function(object, newdata, se.fit = FALSE, scale = NULL, df = Inf,
	     interval = c("none", "confidence", "prediction"),
	     level = .95,  type = c("response", "terms"),
	     terms = NULL, na.action = na.pass, pred.var = res.var/weights,
             weights = 1, ...)
{
    tt <- terms(object)
    if(missing(newdata) || is.null(newdata)) {
	mm <- X <- model.matrix(object)
	mmDone <- TRUE
	offset <- object$offset
    }
    else {
        Terms <- delete.response(tt)
        m <- model.frame(Terms, newdata, na.action = na.action,
                         xlev = object$xlevels)
        if(!is.null(cl <- attr(Terms, "dataClasses"))) .checkMFClasses(cl, m)
        X <- model.matrix(Terms, m, contrasts.arg = object$contrasts)
        offset <- rep(0, nrow(X))
        if (!is.null(off.num <- attr(tt, "offset")))
            for(i in off.num)
                offset <- offset + eval(attr(tt, "variables")[[i+1]], newdata)
	if (!is.null(object$call$offset))
	    offset <- offset + eval(object$call$offset, newdata)
	mmDone <- FALSE
    }
    n <- length(object$residuals) # NROW(object$qr$qr)
    p <- object$rank
    p1 <- seq_len(p)
    piv <- object$qr$pivot[p1]
    if(p < ncol(X) && !(missing(newdata) || is.null(newdata)))
	warning("prediction from a rank-deficient fit may be misleading")
### NB: Q[p1,] %*% X[,piv] = R[p1,p1]
    beta <- object$coefficients
    predictor <- drop(X[, piv, drop = FALSE] %*% beta[piv])
    if (!is.null(offset))
	predictor <- predictor + offset

    interval <- match.arg(interval)
    if (interval == "prediction") {
        if (missing(newdata))
            warning("Predictions on current data refer to _future_ responses\n")
        if (missing(newdata) && missing(weights))
        {
            w <-  weights.default(object)
            if (!is.null(w)) {
                weights <- w
                warning("Assuming prediction variance inversely proportional to weights used for fitting\n")
            }
        }
        if (!missing(newdata) && missing(weights) && !is.null(object$weights) && missing(pred.var))
            warning("Assuming constant prediction variance even though model fit is weighted\n")
        if (inherits(weights, "formula")){
            if (length(weights) != 2L)
                stop("'weights' as formula should be one-sided")
            d <- if(missing(newdata) || is.null(newdata))
                model.frame(object)
            else
                newdata
            weights <- eval(weights[[2L]], d, environment(weights))
        }
    }

    type <- match.arg(type)
    if(se.fit || interval != "none") {
	res.var <-
	    if (is.null(scale)) {
		r <- object$residuals
		w <- object$weights
		rss <- sum(if(is.null(w)) r^2 else r^2 * w)
		df <- n - p
		rss/df
	    } else scale^2
	if(type != "terms") {
            if(p > 0) {
                XRinv <-
                    if(missing(newdata) && is.null(w))
                        qr.Q(object$qr)[, p1, drop = FALSE]
                    else
                        X[, piv] %*% qr.solve(qr.R(object$qr)[p1, p1])
#	NB:
#	 qr.Q(object$qr)[, p1, drop = FALSE] / sqrt(w)
#	looks faster than the above, but it's slower, and doesn't handle zero
#	weights properly
#
                ip <- drop(XRinv^2 %*% rep(res.var, p))
            } else ip <- rep(0, n)
	}
    }

    if (type == "terms") { ## type == "terms" ------------

	if(!mmDone) { mm <- model.matrix(object); mmDone <- TRUE }
	## asgn <- attrassign(mm, tt) :
	aa <- attr(mm, "assign")
	ll <- attr(tt, "term.labels")
	hasintercept <- attr(tt, "intercept") > 0L
	if (hasintercept)
	    ll <- c("(Intercept)", ll)
	aaa <- factor(aa, labels = ll)
	asgn <- split(order(aa), aaa)
	if (hasintercept) {
	    asgn$"(Intercept)" <- NULL
	    if(!mmDone) { mm <- model.matrix(object); mmDone <- TRUE }
	    avx <- colMeans(mm)
	    termsconst <- sum(avx[piv] * beta[piv])
	}
	nterms <- length(asgn)
        if(nterms > 0) {
            predictor <- matrix(ncol = nterms, nrow = NROW(X))
            dimnames(predictor) <- list(rownames(X), names(asgn))

            if (se.fit || interval != "none") {
                ip <- matrix(ncol = nterms, nrow = NROW(X))
                dimnames(ip) <- list(rownames(X), names(asgn))
                Rinv <- qr.solve(qr.R(object$qr)[p1, p1])
            }
            if(hasintercept)
                X <- sweep(X, 2L, avx, check.margin=FALSE)
            unpiv <- rep.int(0L, NCOL(X))
            unpiv[piv] <- p1
            ## Predicted values will be set to 0 for any term that
            ## corresponds to columns of the X-matrix that are
            ## completely aliased with earlier columns.
            for (i in seq.int(1L, nterms, length.out = nterms)) {
                iipiv <- asgn[[i]]      # Columns of X, ith term
                ii <- unpiv[iipiv]      # Corresponding rows of Rinv
                iipiv[ii == 0L] <- 0L
                predictor[, i] <-
                    if(any(iipiv > 0L)) X[, iipiv, drop = FALSE] %*% beta[iipiv]
                    else 0
                if (se.fit || interval != "none")
                    ip[, i] <-
                        if(any(iipiv > 0L))
                            as.matrix(X[, iipiv, drop = FALSE] %*%
                                      Rinv[ii, , drop = FALSE])^2 %*% rep.int(res.var, p)
                        else 0
            }
            if (!is.null(terms)) {
                predictor <- predictor[, terms, drop = FALSE]
                if (se.fit)
                    ip <- ip[, terms, drop = FALSE]
            }
        } else { # no terms
            predictor <- ip <- matrix(0, n, 0L)
        }
	attr(predictor, 'constant') <- if (hasintercept) termsconst else 0
    }

### Now construct elements of the list that will be returned

    if(interval != "none") {
	tfrac <- qt((1 - level)/2, df)
	hwid <- tfrac * switch(interval,
			       confidence = sqrt(ip),
			       prediction = sqrt(ip+pred.var)
			       )
	if(type != "terms") {
	    predictor <- cbind(predictor, predictor + hwid %o% c(1, -1))
	    colnames(predictor) <- c("fit", "lwr", "upr")
	}
	else {
	    lwr <- predictor + hwid
	    upr <- predictor - hwid
	}
    }
    if(se.fit || interval != "none") se <- sqrt(ip)
    if(missing(newdata) && !is.null(na.act <- object$na.action)) {
	predictor <- napredict(na.act, predictor)
	if(se.fit) se <- napredict(na.act, se)
    }
    if(type == "terms" && interval != "none") {
	if(missing(newdata) && !is.null(na.act)) {
	    lwr <- napredict(na.act, lwr)
	    upr <- napredict(na.act, upr)
	}
	list(fit = predictor, se.fit = se, lwr = lwr, upr = upr,
	     df = df, residual.scale = sqrt(res.var))
    } else if (se.fit)
	list(fit = predictor, se.fit = se,
	     df = df, residual.scale = sqrt(res.var))
    else predictor
}
