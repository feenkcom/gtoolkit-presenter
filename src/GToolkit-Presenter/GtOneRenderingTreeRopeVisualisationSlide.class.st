Class {
	#name : #GtOneRenderingTreeRopeVisualisationSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtOneRenderingTreeRopeVisualisationSlide >> create [
	<return: #Object>

	| text styler targetElement targetContainer container highlighted m treeElement |
	text := (Number >> #printString) sourceCode asRopedText.
	styler := BrRBTextStyler new.
	styler classOrMetaClass: OrderedCollection.
	styler style: text.
	text.

	targetElement := (text gtTreeFor: GtPhlowEmptyView new) asElementDo: #yourself.
	targetElement forceLayout.

	targetContainer := BlElement new 
	    constraintsDo: [:c |c horizontal matchParent. c vertical matchParent];
	    margin: (BlInsets all: 10);
	    background: Color white;
	    look: BrShadowLook;
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
	        | nodeElement |
	        nodeElement := BlElement new geometry: BlEllipse new; background: Color gray; size: 50@50.
	        el userData at: #nodeElement put: nodeElement ];
	    with: targetElement withAllChildrenBreadthFirst.
	m edges connectFrom: #parent.
	m layout horizontalTree levelDistance: 1.
	treeElement := m asElement.
	container addChild: (treeElement constraintsDo: [:c |c horizontal matchParent. c vertical matchParent]).

	targetElement withAllChildrenBreadthFirst do: [:el | 
	    el when: BlMouseEnterEvent do: [:event | 
	        treeElement allChildrenBreadthFirstDetect: [:node | node graph model = el] ifFound: [:node |
	        highlighted do: [:each | each background: Color gray].
	        highlighted := OrderedCollection new.
	        el withAllParents do: [:toHighlight | 
	            toHighlight userData at: #nodeElement ifPresent: [ :nodeElement | nodeElement graph model notNil ifTrue: [
	                highlighted add: nodeElement.
	                nodeElement background: Color red ] ] ].
	        event consumed: true ]]].

	^ container
]
