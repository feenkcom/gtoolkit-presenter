"
I am a playground live slide. I receive a collection of snippets and display a playground with those snippets.

{{gtMethod:GtExampleLiveShow>>#playgroundExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtPlaygroundLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'page'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtPlaygroundLiveSlide >> codeFromMethod: aMethod [
	| notTemp |
	notTemp := aMethod ast body statements first.

	^ String streamContents: [ :stream |
		aMethod ast comments ifNotEmpty: [
			stream
				nextPutAll: '"';
				nextPutAll: aMethod ast comments first contents;
				nextPutAll: '"';
				nextPutAll: String cr].
			
		(aMethod sourceCode 
			copyFrom: notTemp start to: aMethod ast stop) lines 
				do: [ :aLine |
					stream nextPutAll: (aLine withoutPrefix: String tab) ]
				separatedBy: [ stream cr ] ]
]

{ #category : #'api - instantiation' }
GtPlaygroundLiveSlide >> create [
	| toolElement |
	toolElement := LePageToolContentTreeElement new
			withTitleOnly;
			padding: (BlInsets
					top: 0
					right: 10
					bottom: 0
					left: 10);
			pageViewModel: (page asContentUIModel shouldFocusFirstSnippet: true).
	^ GtPagerSettings usedPager createWrappedOn: toolElement
]

{ #category : #initialization }
GtPlaygroundLiveSlide >> initialize [
	super initialize.
	
	page := LePage unnamedPageWithDefaultTitle: 'Playground'
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> inspectSnippetAt: aPosition [
	| aScripter |
	aScripter := BlScripter new.
	aScripter
		substep: 'Playground Element'
		do: [ :aStep | 
			aStep set
				label: 'Playground';
				element: [ self asElement ];
				play ].
	aScripter wait
		forEmptySpaceTaskQueue;
		play.
	aScripter
		substep: 'Evaluate and inspect snippet'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on evaluate and inspect button';
						id: GtSourceCoderDoItAndGoActionId index: aPosition ].
			aStep wait
				forEmptySpaceTaskQueue;
				play ].
	^ aScripter elementWithoutParent
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> newSnippet: el [	
	page addSnippet: (LePharoSnippet code: el)
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> newSnippetFromMethod: aMethod [
	self newSnippet: ((self codeFromMethod: aMethod))
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> snippets: aCollection [
	aCollection do: [ :el | self newSnippet: el ]
]
