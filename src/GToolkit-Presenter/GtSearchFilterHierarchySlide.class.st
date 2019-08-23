Class {
	#name : #GtSearchFilterHierarchySlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSearchFilterHierarchySlide >> create [
	^ (GtSearchFilter gtHierarchyFor: GtPhlowView empty) asElementDo: [ :e | e ]
]
