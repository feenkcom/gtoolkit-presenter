Class {
	#name : #GtMethodSlidesCollector,
	#superclass : #GtPhlowCollector,
	#instVars : [
		'definingMethod'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtMethodSlidesCollector >> collect [
	<return: #Array of: #GtMethodSlide>
	<gtCollector>
	| theViews |
	theViews := self collectPragmas
		collect: [ :eachPragma | 
			GtMethodSlide new definingMethod: eachPragma method asRingDefinition ].
	^ theViews
]

{ #category : #accessing }
GtMethodSlidesCollector >> defaultPragmaNames [
	^ #( #gtSlide ).
]

{ #category : #accessing }
GtMethodSlidesCollector >> initialize [
	super initialize.
]
