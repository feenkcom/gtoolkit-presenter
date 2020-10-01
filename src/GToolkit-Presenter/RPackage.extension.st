Extension { #name : #RPackage }

{ #category : #'*GToolkit-Presenter' }
RPackage >> gtSlidesAllContained [
	"I obtain all slides contained in this package by collecting all slides 
	contained by the classes in this package."
	| examples |
	examples := ((self definedClasses reject: [ :aClass | 
			aClass isAbstract or: [ aClass isTrait ] ])
		asSortedCollection: [ :a :b | a name <= b name ])
		flatCollect: #gtSlidesAll.
	^ examples asOrderedCollection
]
