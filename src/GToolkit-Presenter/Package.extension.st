Extension { #name : #Package }

{ #category : #'*GToolkit-Presenter' }
Package >> gtSlideBuildersAllContained [
	"I obtain all slide builders contained in this package by collecting all slide builders 
	contained by the classes in this package."
	| sideBuilders |
	sideBuilders := ((self definedClasses reject: [ :aClass | 
			aClass isAbstract or: [ aClass isTrait ] ])
		asSortedCollection: [ :a :b | a name <= b name ])
		flatCollect: #gtSlideBuildersAll.
	^ sideBuilders asOrderedCollection
]

{ #category : #'*GToolkit-Presenter' }
Package >> gtSlidesAllContained [
	"I obtain all slides contained in this package."
	^ self gtSlideBuildersAllContained collect: [:each | each build ]
]
