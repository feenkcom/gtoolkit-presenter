Class {
	#name : #GtExampleSlide,
	#superclass : #GtSlide,
	#instVars : [
		'method'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtExampleSlide >> create [
	| container coder coderElement inspectorElement inspectorContainer |
	
	container := BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets all: 5);
		padding: (BlInsets all: 5);
		layout: BlLinearLayout horizontal.
	
	coder := GtPharoMethodCoder forMethod: method.
	coderElement := (coder asCoderUIModel expanded: true) asElement.
	coderElement
		forceLayout;
		vMatchParent;
		margin: (BlInsets top: 5 right: 15 bottom: 5 left: 5);
		hMatchParent.
	
	inspectorContainer := BlElement new
		constraintsDo: [ :c |
			c vertical matchParent.
			c horizontal matchParent ];
		margin: (BlInsets top: 5 right: 5 bottom: 5 left: 15);
		layout: BlLinearLayout horizontal;
		background: Color white;
		look: BrShadowLook.
	
	inspectorElement := (method gtExample returnValue gtViewsFor: GtPhlowView empty) asElementDo: [ :e | e ].
	inspectorElement forceLayout.
	inspectorContainer addChild: inspectorElement.
	
	^ container
		addChild: coderElement;
		addChild: inspectorContainer.
]

{ #category : #accessing }
GtExampleSlide >> method: aMethod [
	method := aMethod.
]
