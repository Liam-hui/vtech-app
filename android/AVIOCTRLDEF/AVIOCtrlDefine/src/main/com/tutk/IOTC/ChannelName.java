package com.tutk.IOTC;

public class ChannelName {

	public int    channelIndex;
	public String channelName;
	public boolean       select   = true;

	public ChannelName(int channelIndex, String channelName) {
		this.channelIndex = channelIndex;
		this.channelName = channelName;
	}
}
