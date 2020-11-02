Extension { #name : #RPackage }

{ #category : #'*GToolkit-Presenter' }
RPackage >> gtSlidesAllContained [
	"I obtain all slides contained in this package."
	^ self gtSlideBuildersAllContained collect: [:each | each build]
]
