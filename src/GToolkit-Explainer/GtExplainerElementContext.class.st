Class {
	#name : #GtExplainerElementContext,
	#superclass : #Object,
	#instVars : [
		'element',
		'model',
		'isExplanation',
		'isTarget',
		'isExplanationHolder'
	],
	#category : #'GToolkit-Explainer'
}

{ #category : #'instance creation' }
GtExplainerElementContext class >> on: anElement [
	^ self new element: anElement
]

{ #category : #'as yet unclassified' }
GtExplainerElementContext >> allExplanationChildrenWithModel: aModel do: aBlock [
	| children |
	children := self element
		allChildrenBreadthFirstSelect: [ :child | child explainer isExplanation and: [child explainer model = aModel ]].
	children do: aBlock.
]

{ #category : #'as yet unclassified' }
GtExplainerElementContext >> allTargetChildrenWithModel: aModel do: aBlock [
	| children |
	children := self element
		allChildrenBreadthFirstSelect: [ :child | child explainer isTarget and: [child explainer model = aModel ]].
	children do: aBlock.
]

{ #category : #accessing }
GtExplainerElementContext >> element [
	^ element
]

{ #category : #accessing }
GtExplainerElementContext >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtExplainerElementContext >> firstExplanationChildWithModel: aModel do: aBlock [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child explainer isExplanation and: [ child explainer model = aModel ] ] 
		ifFound: aBlock
]

{ #category : #accessing }
GtExplainerElementContext >> firstExplanationHolderParent [
	"Return an element that plays a role of the explanation holder.
	Explainer treats that element as a context in which it searches
	for explainer target and corresponding explanation for a some explanation model"
	<return: #BlElement>

	^ self element 
		allParentsDetect: [ :parent | parent explainer isExplanationHolder ] 
		ifFound: [ :parent | parent ]
		ifNone: [ self element topMostParent ]
]

{ #category : #accessing }
GtExplainerElementContext >> firstTargetChildWithModel: aModel do: aBlock [
	^ self element 
		allChildrenBreadthFirstDetect: [ :child | child explainer isTarget and: [ child explainer model = aModel ] ] 
		ifFound: aBlock
]

{ #category : #accessing }
GtExplainerElementContext >> initialize [
	super initialize.
]

{ #category : #accessing }
GtExplainerElementContext >> isExplanation [
	^ isExplanation ifNil: [ false ]
]

{ #category : #accessing }
GtExplainerElementContext >> isExplanation: aBoolean [
	isExplanation := aBoolean
]

{ #category : #accessing }
GtExplainerElementContext >> isExplanationHolder [
	^ isExplanationHolder ifNil: [ false ]
]

{ #category : #accessing }
GtExplainerElementContext >> isExplanationHolder: aBoolean [
	"Optionally mark an element as an explanation holder.
	It is used by #firstExplanationHolderParent to find a relative top most container
	for which explainer is scoped"

	isExplanationHolder := aBoolean
]

{ #category : #accessing }
GtExplainerElementContext >> isTarget [
	^ isTarget ifNil: [ false ]
]

{ #category : #accessing }
GtExplainerElementContext >> isTarget: anObject [
	isTarget := anObject
]

{ #category : #accessing }
GtExplainerElementContext >> model [
	^ model
]

{ #category : #accessing }
GtExplainerElementContext >> model: anObject [
	model := anObject
]
