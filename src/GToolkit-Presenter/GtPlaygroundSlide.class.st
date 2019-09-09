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
	^ GtInspector createOnPlayBook: playbook
]

{ #category : #initialization }
GtPlaygroundSlide >> initialize [
	playbook := GtPlayBook newDefault.
]

{ #category : #accessing }
GtPlaygroundSlide >> playbook: aBlock [
	playbook := aBlock
]

{ #category : #accessing }
GtPlaygroundSlide >> snippets: aCollection [
	playbook := GtPlayBook newDefault.
	playbook pages first snippets first sourceCode: aCollection first.
	aCollection allButFirst do: [:el |
		playbook pages first addSnippet: GtCoderSnippet new.
		playbook pages last snippets last sourceCode: el]
]
