Class {
	#name : #GtNewSlideShow,
	#superclass : #Object,
	#instVars : [
		'slides',
		'background'
	],
	#category : #'GToolkit-Presenter-Model'
}

{ #category : #'instance creation' }
GtNewSlideShow class >> create: aSlideshowObject [
	| theSlides |
	
	theSlides := GtSlidesCollector new
		object: aSlideshowObject;
		from: aSlideshowObject class;
		to: aSlideshowObject class;
		collect.

	theSlides := theSlides sorted: [ :a :b | a priority < b priority ].
	theSlides := theSlides collect: [ :eachSlide |
		GtNewSlide new stencil: eachSlide ].

	^ self new slides: theSlides
]

{ #category : #'api - customization' }
GtNewSlideShow >> background [

	^ background
]

{ #category : #'api - customization' }
GtNewSlideShow >> background: anObject [

	background := anObject
]

{ #category : #'gt-extension' }
GtNewSlideShow >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 3;
		stencil: [ GtNewSlideShowElement new slideShow: self ]
]

{ #category : #'gt-extension' }
GtNewSlideShow >> gtSlidesFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Slides';
		  priority: 5;
		  items: [ slides ];
		  column: 'Index' text: [ :each :index | index ] width: 70;
		  column: 'Slide' text: [ :each | each ];
		  column: 'Stencil' text: [ :each | each stencil ];
		  column: 'Cache' text: [ :each |
				each isCached 
					ifTrue: [ 'Cached' asRopedText foreground: BrGlamorousColors successBorderColor ]
					ifFalse: [ 'Not cached' asRopedText foreground: BrGlamorousColors darkBorderColor  ] ]
				width: 120
]

{ #category : #initialization }
GtNewSlideShow >> initialize [
	super initialize.
	
	slides := #().
	background := Color transparent
]

{ #category : #'api - testing' }
GtNewSlideShow >> isFirstSlide: aSlide [
	^ self slides first == aSlide
]

{ #category : #'api - testing' }
GtNewSlideShow >> isLastSlide: aSlide [
	^ self slides last == aSlide
]

{ #category : #'api - slides accessing' }
GtNewSlideShow >> slideAfter: aSlide do: aBlock [
	| aSlideIndex |
	
	aSlideIndex := self slides
		indexOf: aSlide
		ifAbsent: [ ^ self ].

	self
		slideAt: aSlideIndex + 1
		do: aBlock
]

{ #category : #'api - slides accessing' }
GtNewSlideShow >> slideAt: aSlideIndex do: aBlock [
	| aSlide |

	aSlide := self slides
		at: aSlideIndex
		ifAbsent: [ ^ self ].
		
	aBlock value: aSlide
]

{ #category : #'api - slides accessing' }
GtNewSlideShow >> slideBefore: aSlide do: aBlock [
	| aSlideIndex |
	
	aSlideIndex := self slides
		indexOf: aSlide
		ifAbsent: [ ^ self ].

	self
		slideAt: aSlideIndex - 1
		do: aBlock
]

{ #category : #'api - slides accessing' }
GtNewSlideShow >> slides [

	^ slides
]

{ #category : #initialization }
GtNewSlideShow >> slides: anObject [

	slides := anObject
]
