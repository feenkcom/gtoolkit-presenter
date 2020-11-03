Extension { #name : #RPackage }

{ #category : #'*GToolkit-Presenter' }
RPackage >> gtSlideBuildersAllContained [
	"I obtain all slide builders contained in this package by collecting all slide builders 
	contained by the classes in this package."
	| examples |
	examples := ((self definedClasses reject: [ :aClass | 
			aClass isAbstract or: [ aClass isTrait ] ])
		asSortedCollection: [ :a :b | a name <= b name ])
		flatCollect: #gtSlideBuildersAll.
	^ examples asOrderedCollection
]

{ #category : #'*GToolkit-Presenter' }
RPackage >> gtSlidesAllContained [
	"I obtain all slides contained in this package."
	^ self gtSlideBuildersAllContained collect: [:each | each build]
]
