Class {
	#name : #GtSearchFilterHierarchyLiveSlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSearchFilterHierarchyLiveSlide >> create [
	^ (GtSearchMethodsFilter gtHierarchyFor: GtPhlowView empty) asElementDo: [ :e | e ]
]
