"
I am live tree element live slide. I receive an element and display it on the left and on the right i show a live tree of the element on the left.

{{gtMethod:GtExampleLiveShow>>#liveElementTreeSlideExampleFor:|expanded=}}


"
Class {
	#name : #GtLiveElementTreeLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'targetElement'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtLiveElementTreeLiveSlide >> create [
	| targetContainer container highlighted m treeElement |
	targetContainer := BlElement new 
		constraintsDo: [:c |c horizontal matchParent. c vertical matchParent];
		margin: (BlInsets all: 10);
		background: Color white;
		aptitude: BrShadowAptitude;
		layout: BlLinearLayout new.

	container := BlElement new 
		layout: BlLinearLayout horizontal;
		constraintsDo: [:c |c horizontal matchParent. c vertical matchParent].
	targetContainer addChild: (targetElement constraintsDo: [:c |c horizontal matchParent. c vertical matchParent]).
	container addChild: targetContainer.

	highlighted := OrderedCollection new.

	m := GtMondrian new.
	m nodes 
		stencil: [:el | 
			| nodeElement meta |
			meta := el userData associations select: [:each | each value class name endsWith: 'Context'].
			nodeElement := BlElement new 
				background: Color white; 
				aptitude: BrShadowAptitude; 
				margin: (BlInsets all: 10);
				when: BlClickEvent do: [:e | e target phlow spawnObject: el].
			meta isEmpty 
				ifTrue: [ nodeElement geometry: BlEllipseGeometry new; size: 10@10 ];
				ifFalse: [ nodeElement 
					constraintsDo: [:c | c vertical fitContent. c horizontal fitContent];
					layout: BlLinearLayout vertical;
					padding: (BlInsets all: 10). 
					meta do: [:aMeta | nodeElement addChild: (BlTextElement new text: (aMeta key asRopedText glamorousRegularFont fontSize: 14; foreground: Color black) ) ]].
			el userData at: #nodeElement put: nodeElement ];
		with: targetElement withAllChildrenBreadthFirst.
	m edges 
		stencil: [ BlSigmoidElement new beHorizontal; sharpness: 0.1; border: (BlBorder paint: (BrGlamorousColors defaultHeaderBackgroundColor alpha: 0.5) width: 3) ];
		fromRightCenter;
		toLeftCenter;
		connectFrom: #parent.
	m layout horizontalTree levelDistance: 30; nodeDistance: 10.
	treeElement := m asElement.
	container addChild: (treeElement constraintsDo: [:c |
		c horizontal matchParent.
		c vertical matchParent]).

	targetElement withAllChildrenBreadthFirst do: [:el | 
		el when: BlMouseEnterEvent do: [:event | 
			treeElement allChildrenBreadthFirstDetect: [:node | node graph model = el] ifFound: [:node |
			highlighted do: [:each | each background: Color white].
			highlighted := OrderedCollection new.
			el withAllParents do: [:toHighlight | 
				toHighlight userData at: #nodeElement ifPresent: [ :nodeElement | nodeElement graph model notNil ifTrue: [
					highlighted add: nodeElement.
					nodeElement background: BrGlamorousColors textHighlightColor] ] ].
			event consumed: true ]]].

	^ container
]

{ #category : #initialization }
GtLiveElementTreeLiveSlide >> initialize [ 
	| text styler |
	super initialize.
	text := (Number >> #printString) sourceCode asRopedText.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: OrderedCollection.
	styler style: text.
	
	targetElement := (text gtTreeFor: GtPhlowEmptyView new) asElementDo: #yourself.
	targetElement forceLayout.
]

{ #category : #accessing }
GtLiveElementTreeLiveSlide >> targetElement [
	^ targetElement.
]

{ #category : #accessing }
GtLiveElementTreeLiveSlide >> targetElement: anObject [
	targetElement := anObject
]
