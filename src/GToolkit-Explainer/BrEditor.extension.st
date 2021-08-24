Extension { #name : 'BrEditor' }

{ #category : '*GToolkit-Explainer' }
BrEditor >> hasValidators [
	^ self userData
		at: #explainer
		ifPresent: [ :item | item hasValidators ]
		ifAbsent: [ false ]
]

{ #category : '*GToolkit-Explainer' }
BrEditor >> installValidatorsFor: modelCollection [
	modelCollection do: [ :each | self explainer addValidator: each ].
	textStyleHandler
		action:
			[ :anEvent | 
			self editor stylerStrategy
				styleTextInEditorElement: self
				thenDo:
					[ :text | 
					anEvent afterAction value: text.
					self updateValidatorsFor: text ] ]
]

{ #category : '*GToolkit-Explainer' }
BrEditor >> updateValidatorsFor: aText [
	| originalValues |
	originalValues := Dictionary new.
	originalValues addAll: self explainer validators.
	self explainer clearValidators.
	aText
		attributesDo:
			[ :attrs | attrs do: [ :each | (each isKindOf: GtValidatorTextAttribute) ifTrue: [ self explainer confirmValidatorFor: each model ] ] ].
	self explainer validators
		keysAndValuesDo:
			[ :key :value | 
			value ~= (originalValues at: key ifAbsent: [ false ])
				ifTrue: [ self explainer firstExplanationHolderParent explainer updateValidatorTargetsOf: key to: value ] ]
]
