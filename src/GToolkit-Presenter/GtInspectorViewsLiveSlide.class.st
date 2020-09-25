Class {
	#name : #GtInspectorViewsLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'slideType'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtInspectorViewsLiveSlide >> allViews [
	slideType := GtAllViewsLiveSlide new.
]

{ #category : #'api - instantiation' }
GtInspectorViewsLiveSlide >> create [
	^ slideType.
]

{ #category : #accessing }
GtInspectorViewsLiveSlide >> customViews [
	slideType := GtCustomViewsLiveSlide new.
]

{ #category : #accessing }
GtInspectorViewsLiveSlide >> multipleViewsForOneObject [
	slideType := GtMultipleViewsForOneObjectLiveSlide new.
]

{ #category : #accessing }
GtInspectorViewsLiveSlide >> rawViews [
	slideType := GtRawViewsLiveSlide new.
]
