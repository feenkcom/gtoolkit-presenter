Class {
	#name : #GtCheckedValidatorTargetAptitude,
	#superclass : #GtValidatorTargetAptitude,
	#category : #'GToolkit-Explainer-Validator'
}

{ #category : #private }
GtCheckedValidatorTargetAptitude >> updateWidgetWithValue: aBoolean [
	self widgetDo: [ :each | each checked: aBoolean ]
]
