Class {
	#name : #GtSlide,
	#superclass : #BrStencil,
	#instVars : [
		'slideShow',
		'cachedElement',
		'previewElement'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtSlide >> asCachedElement [
	"Answer the receiver's cached element.
	If the contents hasn't yet been generated, answer the rendering element.
	Must be called from the UI process."

	cachedElement hasChildren ifFalse: [ cachedElement addChild: self renderingElement ].
	^ cachedElement
]

{ #category : #accessing }
GtSlide >> asPreviewElement [
	"Answer the receiver's preview element.
	If the contents hasn't yet been generated, answer the rendering element.
	Must be called from the UI process."

	previewElement hasChildren ifFalse: [ previewElement addChild: self renderingElement ].
	^ previewElement

]

{ #category : #private }
GtSlide >> generateElements [
	"Generate the receiver's element and preview"

	| element formElement |

	"5 seconds wait."
	element := self asElement.
	formElement := element asSpartaForm asElement asPannableElement.
	slideShow enqueueTask: (BlTaskAction new action: [
		cachedElement
			removeChildren;
			addChild: element.
		slideShow updateSlide: self.
		previewElement
			removeChildren;
			addChild: formElement ]).
]

{ #category : #initialization }
GtSlide >> initialize [

	super initialize.
	cachedElement := BlElement new
		constraintsDo: [ :c | c horizontal matchParent. c vertical matchParent ];
		yourself.
	previewElement := BlElement new
		constraintsDo: [ :c | c vertical exact: 100. c horizontal exact: 150 ];
		background: Color white;
		look: BrShadowLook new;
		margin: (BlInsets all: 10);
		yourself.

]

{ #category : #accessing }
GtSlide >> name [
	^ (self class name gtRemovePrefix: 'Gt') gtRemoveSuffix: 'Slide'
]

{ #category : #accessing }
GtSlide >> nextStepWith: aSlider [
	aSlider showSlideAfter: self
]

{ #category : #accessing }
GtSlide >> previousStepWith: aSlider [
	aSlider showSlideBefore: self
]

{ #category : #private }
GtSlide >> queueCacheElementIn: aGtSlideShow [
	"Submit a task to cache the receiver's element"

	| task |
	slideShow := aGtSlideShow.
	task := [ self generateElements ] asBlTktCommand asBlTktSingleCommand.
	task identifier: self.
	task := task asBlTktLoggingCommand.

	BlTktWorkerProvider highUICPUBoundPool schedule: task.
]

{ #category : #private }
GtSlide >> renderingElement [
	"Answer an element that can be added as a child and displays the standard 'rendering' image"

	| rendering element backgroundPaint container |

	rendering := 'Rendering...' asRopedText 
			foreground: Color gray lighter;
			fontSize: 12.
	element := (BlTextElement new 
				text: rendering;
				geometry: (BlRectangle cornerRadius: 7);
				padding: (BlInsets top: 10 left: 20 bottom: 10 right: 20);
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]).
	backgroundPaint := BlLinearGradientPaint new
						stops:
							{(0.0 -> Color white ).
							(0.25 -> Color white darker).
							(1.0 -> Color white)};
						start: 0@0;
						end: 1@1.
	element background: backgroundPaint.
	container := BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: element.
	^container
]
