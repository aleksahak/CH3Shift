# From R

zoom.rev <- function(fun = plot, zoom.col = "red", delay = 3, xlimINI=xlimA, ylimINI=ylimA, ...) 
{
    oldpar <- par(no.readonly = TRUE)
    on.exit(par(oldpar))
    options(locatorBell = FALSE)
    cat("Click mouse at corners of zoom area.\nRight click to stop zooming\n\n")
    fun(...)
    while (TRUE) {
        par(xpd = NA)
        p1 <- locator(n = 1, type = "p", col = zoom.col)
        if (is.null(p1$x)) {
            cat("\n")
            break
        }
        abline(v = p1$x, col = zoom.col)
        abline(h = p1$y, col = zoom.col)
        p2 <- locator(n = 1, type = "p", col = zoom.col)
        if (is.null(p2$x)) {
            cat("\n")
            break
        }
        abline(v = p2$x, col = zoom.col)
        abline(h = p2$y, col = zoom.col)
        Sys.sleep(delay)
        xx <- sort(c(p1$x, p2$x))
        yy <- sort(c(p1$y, p2$y))
        usr <- par()$usr
        usr.x <- usr[2:1]
        usr.y <- usr[4:3]
        usr <- c(usr.x, usr.y)
        if (xx[1] < usr[1]) 
            xx[1] <- xlimINI[2]
        if (xx[2] < usr[1]) 
            xx[2] <- xlimINI[2]
        if (xx[1] > usr[2]) 
            xx[1] <- xlimINI[1]
        if (xx[2] > usr[2]) 
            xx[2] <- xlimINI[1]

        if (yy[1] < usr[3]) 
            yy[1] <- ylimINI[2]
        if (yy[2] < usr[3]) 
            yy[2] <- ylimINI[2]
        if (yy[1] > usr[4]) 
            yy[1] <- ylimINI[1]
        if (yy[2] > usr[4]) 
            yy[2] <- ylimINI[1]
        xlim <- range(xx)
        ylim <- range(yy)
        print(t(data.frame(xlim, ylim)))
        cat("\n")
        par(xpd = FALSE)
        fun(..., xlim = rev(xlim), ylim = rev(ylim))
    }
}
