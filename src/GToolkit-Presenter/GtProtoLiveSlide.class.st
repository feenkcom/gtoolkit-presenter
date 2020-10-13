"
I define a common API that should be implemented by all Live slides.
"
Class {
	#name : #GtProtoLiveSlide,
	#superclass : #BrStencil,
	#instVars : [
		'priority',
		'definingMethod',
		'notes'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #decorating }
GtProtoLiveSlide >> classCoder [
	^ GtClassCoderLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> connector [
	^ GtConnectorForExampleLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #accessing }
GtProtoLiveSlide >> custom: aSlide [
	^ aSlide definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #accessing }
GtProtoLiveSlide >> definingMethod [
	^ definingMethod.
]

{ #category : #accessing }
GtProtoLiveSlide >> definingMethod: aCompiledMethod [
	self unsubscribeFromSystem.
	definingMethod := aCompiledMethod.
	self subscribeToSystem.
]

{ #category : #decorating }
GtProtoLiveSlide >> devKeyboard [
	^ GtDevKeyboardLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> documenter [
	^ GtDocumenterLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> editorElement [
	^ GtEditorElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> element [
	^ GtElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> elementAndElement [
	^ GtElementAndElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> empty [
	^ GtEmptySlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> example [
	^ GtExampleLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> filePicture [
	^ GtFilePictureLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> hasDefiningMethod [
	^ self definingMethod isNotNil
]

{ #category : #decorating }
GtProtoLiveSlide >> inspectorViews [
	^ GtInspectorViewsLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> labelAndElement [
	^ GtLabelAndElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> liveElementTree [
	^ GtLiveElementTreeLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> mash [
	^ GtMashExampleLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #accessing }
GtProtoLiveSlide >> notes [
	^ notes.
]

{ #category : #accessing }
GtProtoLiveSlide >> notes: aString [
	notes := aString.
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> onDefiningMethodChange [
	"I am called when the defining method has changed.
	Subclasses may react to the method definition changes.
	I may be called from a non-UI process."
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> onDefiningMethodRemoved [
	"I am called when the defining method has been removed.
	Subclasses may react to the method definition removal.
	I may be called from a non-UI process."
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> onMethodModified: aMethodModified [
	self hasDefiningMethod ifFalse: [ ^ self ].
	(self definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected)
		ifFalse: [ ^ self ].
	self onDefiningMethodChange.
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> onMethodRemoved: aMethodRemoved [
	self hasDefiningMethod ifFalse: [ ^ self ].
	(aMethodRemoved methodRemoved hasPragmaNamed: #gtSlide) ifFalse: [ ^ self ].
	(self definingMethod gtPhlowIncludesCompiledMethod: aMethodRemoved methodRemoved)
		ifFalse: [ ^ self ].
	self unsubscribeFromSystem.
	self onDefiningMethodRemoved.
]

{ #category : #decorating }
GtProtoLiveSlide >> paragraph [
	^ GtParagraphLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> playground [
	^ GtPlaygroundLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #accessing }
GtProtoLiveSlide >> priority [
	^ priority.
]

{ #category : #accessing }
GtProtoLiveSlide >> priority: anInteger [
	priority := anInteger.
]

{ #category : #decorating }
GtProtoLiveSlide >> searchFiltersHierarchy [
	^ GtSearchFilterHierarchyLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> slideshow [
	^ GtSlideshowLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> spotter [
	^ GtSpotterLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #'private - subscriptions' }
GtProtoLiveSlide >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodModified send: #onMethodModified: to: self;
		when: MethodRemoved send: #onMethodRemoved: to: self.
]

{ #category : #decorating }
GtProtoLiveSlide >> text [
	^ GtTextLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> textAndElement [
	^ GtTextAndElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #decorating }
GtProtoLiveSlide >> title [
	^ GtTitleLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #'private - subscriptions' }
GtProtoLiveSlide >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self.
]

{ #category : #decorating }
GtProtoLiveSlide >> world [
	^ GtWorldLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]
