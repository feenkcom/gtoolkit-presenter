"
I am a Wardley Map slide. I can be created from an exported json string.


"
Class {
	#name : 'GtWardleyMapSlide',
	#superclass : 'GtLiveSlide',
	#instVars : [
		'json'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtWardleyMapSlide >> create [
	| aWardleyMapModel aWardleyMapViewModel aWardleyMapElement |
	<return: #Object>

	aWardleyMapModel := GtWardleyMapFromDictionaryImporter importMapFromJSONString: self json.
	aWardleyMapViewModel := GtWardleyMapViewModel new wardleyMapModel: aWardleyMapModel.
	aWardleyMapElement := GtWardleyMapElement new wardleyMapViewModel: aWardleyMapViewModel.
	aWardleyMapElement evolutionSections: {
		'genesis'.
		'custom built'.
		'product (+rental)'.
		'commodity'
	}.
	^ aWardleyMapElement
]

{ #category : 'initialization' }
GtWardleyMapSlide >> initialize [
	super initialize.
	
	json := '{
	"nodes" : [ ],
	"edges" : [ ]
}'
]

{ #category : 'accessing' }
GtWardleyMapSlide >> json [
	^ json
]

{ #category : 'accessing' }
GtWardleyMapSlide >> json: anObject [
	json := anObject
]
