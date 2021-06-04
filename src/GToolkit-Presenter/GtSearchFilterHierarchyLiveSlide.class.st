"
I am a live slide that displays the tree hierarchy of the filters in Gt.

{{gtMethod:GtExampleLiveShow>>#searchFiltersHierarchySlideFor:|expanded=}}


"
Class {
	#name : #GtSearchFilterHierarchyLiveSlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtSearchFilterHierarchyLiveSlide >> create [
	^ (GtSearchMethodsFilter gtHierarchyFor: GtPhlowView empty) asElementDo: [ :e | e ]
]
