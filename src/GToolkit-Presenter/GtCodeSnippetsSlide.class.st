"
I am a live slide that holds a heading, a collection of text, code and example snippets, and an inspector widget for displaying the results.

See {{gtMethod:name=GtCodeSnippetsSlide>>exampleSlide:}} for usage examples.

```
GtPresenterSlideShow openInSpace: GtCodeSnippetsSlide
```

"
Class {
	#name : #GtCodeSnippetsSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'snippets',
		'heading',
		'elementWeight',
		'inspectorElement',
		'margin',
		'snippetPadding',
		'bodyPadding',
		'containerSize'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtCodeSnippetsSlide >> addCodeSnippet: aSourceString [
	self
		addSnippet: (self extractCoderElementFor: (GtPharoSnippetCoder forSource: aSourceString))
]

{ #category : #accessing }
GtCodeSnippetsSlide >> addExampleSnippet: exampleMethod [
	self
		addSnippet: (self extractCoderElementFor: (GtPharoMethodCoder forMethod: exampleMethod))
]

{ #category : #accessing }
GtCodeSnippetsSlide >> addSnippet: aSnippetElement [
	self snippets add: aSnippetElement
]

{ #category : #accessing }
GtCodeSnippetsSlide >> addTextSnippetV1: aString [
	self addSnippet: (BlTextElement new text: aString asRopedText)
]

{ #category : #accessing }
GtCodeSnippetsSlide >> addTextSnippetV2: aString [
	self
		addSnippet: (self extractTextCoderSnippetElementFor: (LeTextSnippet string: aString) asPreviewElement )
]

{ #category : #'api - instantiation' }
GtCodeSnippetsSlide >> bodyPadding [
	^ bodyPadding
]

{ #category : #accessing }
GtCodeSnippetsSlide >> bodyPadding: aNumber [

	bodyPadding := aNumber
]

{ #category : #accessing }
GtCodeSnippetsSlide >> bottomMargin: aNumber [
	self margin: (self margin withBottom: aNumber)
]

{ #category : #'api - instantiation' }
GtCodeSnippetsSlide >> containerSize [
	^ containerSize
]

{ #category : #accessing }
GtCodeSnippetsSlide >> containerSize: anObject [

	containerSize := anObject
]

{ #category : #'api - instantiation' }
GtCodeSnippetsSlide >> create [
	| container bodyElement snippetsElement headingElement |
	container := BrVerticalPane new
			exact: self containerSize;
			padding: (BlInsets
					top: 40
					right: 20
					bottom: 40
					left: 20).	"The container holds vertical heading and body elements."

	headingElement := BlTextElement new
			margin: (BlInsets all: 1);
			constraintsDo: [ :c | 
				c vertical exact: 40.
				c horizontal fitContent.
				c linear horizontal ];
			text: self heading.	"The heading sits at the top of the page by itself"

	bodyElement := BrHorizontalPane new
			matchParent;
			padding: (BlInsets top: self bodyPadding bottom: self bodyPadding).	"The body holds horizontal snippets and inspector elements."

	snippetsElement := BlElement new
			constraintsDo: [ :c | 
				c linear weight: 1 - elementWeight.
				c vertical matchParent.
				c horizontal matchParent ];
			layout: BlLinearLayout vertical.

	inspectorElement := BrVerticalPane new matchParent.

	self snippets
		do: [ :snippet | 
			snippetsElement
				addChild: (snippet
						padding: (BlInsets top: self snippetPadding bottom: self snippetPadding);
						constraintsDo: [ :c | 
							c horizontal matchParent.
							c vertical fitContent ]) ].

	bodyElement
		addChild: snippetsElement;
		addChild: (inspectorElement
				constraintsDo: [ :c | 
					c linear weight: elementWeight.
					c vertical matchParent.
					c horizontal matchParent ]).

	container
		addChild: headingElement;
		addChild: bodyElement.

	^ container asScalableElement
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ]
]

{ #category : #initialization }
GtCodeSnippetsSlide >> defaultBodyPadding [
	^ 0
]

{ #category : #initialization }
GtCodeSnippetsSlide >> defaultContainerSize [
	^ 900 @ 600
]

{ #category : #accessing }
GtCodeSnippetsSlide >> defaultHeadingFontSize [
	^ 24
]

{ #category : #initialization }
GtCodeSnippetsSlide >> defaultMargin [
	^ BlInsets
		top: 200
		right: 100
		bottom: 200
		left: 100
]

{ #category : #initialization }
GtCodeSnippetsSlide >> defaultSnippetPadding [
	^ 15
]

{ #category : #accessing }
GtCodeSnippetsSlide >> elementWeight [

	^ elementWeight
]

{ #category : #accessing }
GtCodeSnippetsSlide >> elementWeight: anObject [

	elementWeight := anObject
]

{ #category : #accessing }
GtCodeSnippetsSlide >> example [
	<gtExample>
	<noTest>
	^ GtCodeSnippetsSlide new
		heading: 'Slide Heading';
		typeTextSnippet: 'A plain text snippet';
		typeTextSnippet: ('A formatted text snippet' asRopedText
				glamorousRegularFont;
				bold;
				fontSize: 24);
		addCodeSnippet: '"A code snippet"
3+4';
		addCodeSnippet: '"Another code snippet"
2r101010';
		addExampleSnippet: self class >> #exampleMethod
]

{ #category : #accessing }
GtCodeSnippetsSlide >> exampleMethod [
	"This is an example of an example method"

	<gtExample>
	<noTest>
	^ 'I am an example of a string'
]

{ #category : #accessing }
GtCodeSnippetsSlide >> exampleSlide: aSlide [
	"GtPresenterSlideShow openInSpace: GtCodeSnippetsSlide"
	<gtSlide>
	^ aSlide headingAndCode
		priority: 10;
		heading: 'Slide Heading';
		typeTextSnippet: 'A plain text snippet';
		typeTextSnippet: ('A formatted text snippet' asRopedText
				glamorousRegularFont;
				bold;
				fontSize: 18);
		addCodeSnippet: '"A code snippet"
3+4';
		addCodeSnippet: '"Another code snippet"
2r101010';
		addExampleSnippet: self class >> #exampleMethod
]

{ #category : #accessing }
GtCodeSnippetsSlide >> exampleSlideWithOverrides: aSlide [
	"GtPresenterSlideShow openInSpace: GtCodeSnippetsSlide"

	<gtSlide>
	^ (self exampleSlide: aSlide)
		priority: 20;
		leftMargin: 10;
		snippetPadding: 20;
		bodyPadding: 0;
		elementWeight: 0.4
]

{ #category : #accessing }
GtCodeSnippetsSlide >> extractCoderElementFor: aCoder [
	| editor |
	editor := (aCoder asElement query
			// GtSourceCoderExpandedContentElement;
			anyOne)
			removeFromParent;
			hMatchParent;
			vFitContent;
			when: GtPhlowObjectToSpawn
				do: [ :e | 
					self inspectorElement removeChildren
						addChild: ((e object gtViewsFor: GtPhlowView empty)
								asElementDo: [ :x | 
									BrVerticalPane new matchParent
										margin: (BlInsets all: 10);
										aptitude: BrShadowAptitude;
										background: Color white;
										addChild: x ]).
					e consumed: true ].
	^ editor
]

{ #category : #accessing }
GtCodeSnippetsSlide >> extractTextCoderSnippetElementFor: aCoder [
	| editor |
	editor := (aCoder asElement query
			// LeTextCoderSnippetElement;
			anyOne)
			removeFromParent;
			hMatchParent;
			vFitContent;
			when: GtPhlowObjectToSpawn
				do: [ :e | 
					self inspectorElement removeChildren
						addChild: ((e object gtViewsFor: GtPhlowView empty)
								asElementDo: [ :x | 
									BrVerticalPane new matchParent
										margin: (BlInsets all: 10);
										aptitude: BrShadowAptitude;
										background: Color white;
										addChild: x ]).
					e consumed: true ].
	^ editor
]

{ #category : #accessing }
GtCodeSnippetsSlide >> heading [
	^ heading
]

{ #category : #accessing }
GtCodeSnippetsSlide >> heading: aString [
	self
		headingWithFormat: (aString asRopedText
				glamorousRegularFont;
				bold;
				fontSize: self defaultHeadingFontSize)
]

{ #category : #accessing }
GtCodeSnippetsSlide >> headingWithFormat: aRopedText [
	heading := aRopedText
]

{ #category : #initialization }
GtCodeSnippetsSlide >> initialize [
	super initialize.
	self heading: ''.
	snippets := OrderedCollection new.
	self elementWeight: 0.5.
	self margin: self defaultMargin.
	self containerSize: self defaultContainerSize.
	self snippetPadding: self defaultSnippetPadding.
	self bodyPadding: self defaultBodyPadding
]

{ #category : #accessing }
GtCodeSnippetsSlide >> inspectorElement [

	^ inspectorElement
]

{ #category : #accessing }
GtCodeSnippetsSlide >> leftMargin: aNumber [
	self margin: (self margin withLeft: aNumber)
]

{ #category : #accessing }
GtCodeSnippetsSlide >> margin [
	^ margin
]

{ #category : #accessing }
GtCodeSnippetsSlide >> margin: anObject [

	margin := anObject
]

{ #category : #accessing }
GtCodeSnippetsSlide >> rightMargin: aNumber [
	self margin: (self margin withRight: aNumber)
]

{ #category : #'api - instantiation' }
GtCodeSnippetsSlide >> snippetPadding [
	"Top and bottom padding between snippets"
	^ snippetPadding
]

{ #category : #accessing }
GtCodeSnippetsSlide >> snippetPadding: aNumber [
	snippetPadding := aNumber
]

{ #category : #accessing }
GtCodeSnippetsSlide >> snippets [

	^ snippets
]

{ #category : #accessing }
GtCodeSnippetsSlide >> topMargin: aNumber [
	self margin: (self margin withTop: aNumber)
]

{ #category : #accessing }
GtCodeSnippetsSlide >> typeTextSnippet: aString [
	self addTextSnippetV2: aString
]
