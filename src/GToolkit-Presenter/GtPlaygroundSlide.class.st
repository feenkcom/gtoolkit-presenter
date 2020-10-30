Class {
	#name : #GtPlaygroundSlide,
	#superclass : #GtSlide,
	#instVars : [
		'playbook'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtPlaygroundSlide >> create [
	^ GtPlayground createOn: playbook
]

{ #category : #initialization }
GtPlaygroundSlide >> initialize [
	super initialize.
	playbook := GtPlayBook newDefault.
]

{ #category : #accessing }
GtPlaygroundSlide >> inspectSnippetAt: aPosition [
	| aScripter |
	
	aScripter := BlDevScripter new.
	aScripter
		substep: 'Playground Element'
		do: [ :aStep | 
			aStep set
				label: 'Playground';
				element: [ self asElement ] ].
	aScripter
		substep: 'Evaluate and inspect snippet'
		do: [ :aStep | 
			aStep click
				label: 'Click on evaluate and inspect button';
				onBreadthFirstChildOfClass: GtPlayground;
				onChildNamed: #content;
				onBreadthFirstChildOfClass: GtPageSnippetsElement;
				onChildAt: aPosition;
				onBreadthFirstChildOfClass: GtExpandableCoderElement;
				onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
				onBreadthFirstChildOfClass: BrToolbar;
				onChildAt: 2.
			aStep wait forEmptySpaceTaskQueue ].
	aScripter syncContinue.
	^ aScripter elementWithoutParent
]

{ #category : #accessing }
GtPlaygroundSlide >> playbook: aBlock [
	playbook := aBlock
]

{ #category : #accessing }
GtPlaygroundSlide >> snippets: aCollection [
	playbook := GtPlayBook newWithCodeSnippetContent: aCollection first.
	aCollection allButFirst do: [:el |
		playbook pages first addSnippet: GtCoderSnippet new.
		playbook pages last snippets last sourceCode: el]
]
