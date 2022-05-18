Class {
	#name : #GtPresenterSlideSlideExtentChanged,
	#superclass : #Announcement,
	#instVars : [
		'slideExtent'
	],
	#category : #'GToolkit-Presenter-Models - Events'
}

{ #category : #generated }
GtPresenterSlideSlideExtentChanged >> slideExtent [
	<objectGetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ slideExtent
]

{ #category : #generated }
GtPresenterSlideSlideExtentChanged >> slideExtent: aSlideExtent [
	<objectSetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	slideExtent := aSlideExtent
]
