Class {
	#name : #GtPresenterSlideViewModelAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'slideViewModel'
	],
	#category : #'GToolkit-Presenter-View Models - Events'
}

{ #category : #generated }
GtPresenterSlideViewModelAddedAnnouncement >> slideViewModel [
	<objectGetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ slideViewModel
]

{ #category : #generated }
GtPresenterSlideViewModelAddedAnnouncement >> slideViewModel: aSlideViewModel [
	<objectSetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	slideViewModel := aSlideViewModel
]
