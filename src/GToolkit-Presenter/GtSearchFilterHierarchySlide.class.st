Class {
	#name : #GtSearchFilterHierarchySlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSearchFilterHierarchySlide >> create [
	^ (GtSearchMethodsFilter gtHierarchyFor: GtPhlowView empty) asElementDo: [ :e | e ]
]
