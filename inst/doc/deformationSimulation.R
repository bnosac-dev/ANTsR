## ----simdef--------------------------------------------------------------
library( ANTsR )
img    = antsImageRead( getANTsRData( "r16" ) )
ptmat = matrix( c( 95.5, 95.5, 63.5, 63.5 ), ncol=2 )
aa = makePointsImage( ptmat, mask = img * 0 + 1, radius = 16  )
aaDist = iMath( aa, "MaurerDistance") + rnorm( sum( aa>=0  ), sd=5 )
plot( aaDist )
bb = iMath( aa, "MD", 5 )
areg = antsRegistration( aa, aaDist * bb, typeofTransform = "SyNOnly",
  synMetric = "demons", synIterations = 15,
  flowSigma = 6, totalSigma = 3,
  gradStep = 0.2 )
field  = antsImageRead( areg$fwdtransforms[ 1 ] )
warpTx = antsrTransformFromDisplacementField( field )
warped = applyAntsrTransform( warpTx, data = img, reference = img)
field  = antsImageRead( areg$fwdtransforms[ 1 ] )
warpTx = antsrTransformFromDisplacementField( field )
txlist = list( )
ncomp = 6
for ( i in 1:ncomp ) txlist[[ i ]] = warpTx
warped = applyAntsrTransform(
  txlist, data = img, reference = img)

## ----viewdef-------------------------------------------------------------
plot( img )
plot( warped )

## ----viewgrid------------------------------------------------------------
f = areg$fwdtransforms[ 1 ]
grid = createWarpedGrid( img, gridStep = 10, gridWidth = 2,
  fixedReferenceImage = img, transform = rep( f, ncomp ) )
plot( grid )

## ----curvflow,eval=FALSE-------------------------------------------------
#  img = antsImageRead( "precuneus.nii.gz" )
#  msk = thresholdImage( img, 1, Inf )
#  grad = getNeighborhoodInMask( img, msk, rep(0,img@dimension), get.gradient=T,
#    physical.coordinates = T, boundary.condition = 'mean')$gradients
#  kappa = weingartenImageCurvature( smoothImage(img,0.5) ) * msk
#  # convert grad to channels
#  glist=list()
#  for ( k in 1:3 ) {
#    gradimg1 = msk * 0
#    gradimg1[ msk == 1 ] = (-1) * grad[k,] * kappa[ msk == 1 ]
#    glist[[ k ]] = gradimg1
#    }
#  field = mergeChannels( glist ) %>% smoothImage( 1.0 )
#  jac = createJacobianDeterminantImage( img, field )
#  warpTx = antsrTransformFromDisplacementField( field * 0.5 / max( abs( field ) ) )
#  warplist = list( )
#  for ( i in 1:20 )
#    warplist[[ i ]] = warpTx
#  warped = applyAntsrTransform( warplist, data=img, reference=img )
#  # antsImageWrite( warped , '/tmp/temp.nii.gz' )

