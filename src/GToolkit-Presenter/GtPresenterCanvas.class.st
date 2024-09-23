Class {
	#name : #GtPresenterCanvas,
	#superclass : #BlCanvassableElement,
	#instVars : [
		'slideShow',
		'methodsToSlideElement',
		'toolbar'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtPresenterCanvas class >> create: aSlideShow [ 
	^ self new 
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		slideShow: aSlideShow
]

{ #category : #accessing }
GtPresenterCanvas >> extentChangedFor: slide [ 
]

{ #category : #'as yet unclassified' }
GtPresenterCanvas >> methodModified: aMethodModifiedAnnouncement [
	methodsToSlideElement
		at: aMethodModifiedAnnouncement method asRingDefinition
		ifPresent: [ :slideElement | slideElement updateSlide ]
]

{ #category : #'as yet unclassified' }
GtPresenterCanvas >> onAddedToSceneGraph [
	self subscribeToSystem
]

{ #category : #'as yet unclassified' }
GtPresenterCanvas >> onRemovedFromSceneGraph [
	self unsubscribeFromSystem
]

{ #category : #accessing }
GtPresenterCanvas >> positionChangedFor: slide [ 
	| array |
	array := methodsToSlideElement associations collect: [ :association | 
		association key selector -> {association value position . association value extent }
		].
	slideShow class class compile: 'canvasCoordinates', String lf, String tab, '^ ', array storeString
]

{ #category : #accessing }
GtPresenterCanvas >> slideShow: aSlideShow [
	| methodSlides presenterSlides slideElements |
	slideShow := aSlideShow.
	methodSlides := GtMethodSlidesCollector new
			object: slideShow;
			from: slideShow class;
			to: slideShow class;
			collect.
	presenterSlides := methodSlides
			collect: [ :each | GtPresenterSlide new stencil: each ].
	methodsToSlideElement := Dictionary new.
	slideElements := presenterSlides
			collect: [ :slide | 
				| slideContainer |
				slideContainer := GtPresenterCanvasSlide for: slide.
				slideContainer
					when: BlElementPositionChangedEvent
						do: [ :e | self positionChangedFor: slide ];
					when: BlElementExtentChangedEvent
						do: [ :e | self extentChangedFor: slide ].
				methodsToSlideElement at: slide stencil definingMethod put: slideContainer ].
	(slideShow class class canUnderstand: #canvasCoordinates)
		ifTrue: [ slideShow class canvasCoordinates
				do: [ :assoc | 
					slideShow class
						compiledMethodAt: assoc key
						ifPresent: [ :aMethod | 
							methodsToSlideElement
								at: aMethod asRingDefinition
								ifPresent: [ :anElement | 
									anElement
										relocate: assoc value first;
										size: assoc value last ] ] ] ].
	self addChildren: slideElements
]

{ #category : #'as yet unclassified' }
GtPresenterCanvas >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodModified send: #methodModified: to: self
]

{ #category : #'as yet unclassified' }
GtPresenterCanvas >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
