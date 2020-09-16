Class {
	#name : #GtSlidesCollector,
	#superclass : #GtPhlowCollector,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtSlidesCollector >> collect [
	<return: #Array of: #GtLiveSlide>
	<gtCollector>
	| theViews |
	theViews := self collectPragmas
		collect: [ :eachPragma | 
			| aSlide |
			aSlide := thisContext
				object: self object
				perform: eachPragma methodSelector
				withArguments: {GtEmptySlide new}
				inClass: self object class.
			aSlide ].
	self sortByPriority: theViews.
	^ theViews
]

{ #category : #accessing }
GtSlidesCollector >> defaultPragmaNames [
	^ #( #gtSlide ).
]

{ #category : #accessing }
GtSlidesCollector >> initialize [
	super initialize.
]
