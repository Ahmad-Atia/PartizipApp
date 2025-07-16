import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  ActivityIndicator
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useApp } from '../context/AppContext';
import { styles } from '../styles/ProfileScreen.style';
import UserService from '../services/UserService';

const ProfileScreen = ({ navigation }) => {
  const { user, logout } = useApp();
  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProfile = async () => {
      if (user?.id) {
        const result = await UserService.getUserProfile(user.id);
        if (result.success) {
          setProfile(result.user);
        }
      }
      setLoading(false);
    };
    fetchProfile();
  }, [user]);

  const handleLogout = async () => {
    Alert.alert(
      'Logout',
      'Are you sure you want to logout?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Logout',
          style: 'destructive',
          onPress: async () => {
            await logout();
          }
        }
      ]
    );
  };

  const handleEditProfile = () => {
    // Navigate to edit profile screen
    Alert.alert('Coming Soon', 'Profile editing will be available soon!');
  };

  const menuItems = [
    {
      icon: 'person-outline',
      title: 'Edit Profile',
      onPress: handleEditProfile
    },
    {
      icon: 'calendar-outline',
      title: 'Events',
      onPress: () => navigation.navigate('Events')
    },
    {
      icon: 'help-circle-outline',
      title: 'Help & Support',
      onPress: () => Alert.alert('Coming Soon', 'Help & Support will be available soon!')
    },
    {
      icon: 'log-out-outline',
      title: 'Logout',
      onPress: handleLogout,
      color: '#ff4444'
    }
  ];

  if (user?.guest) {
    return (
      <View style={styles.container}>
        <View style={styles.guestHeader}>
          <Ionicons name="person-circle-outline" size={80} color="#ccc" />
          <Text style={styles.guestTitle}>Guest Mode</Text>
          <Text style={styles.guestSubtitle}>
            Login to access your profile and save your preferences
          </Text>
          <TouchableOpacity
            style={styles.loginButton}
            onPress={() => logout()}
          >
            <Text style={styles.loginButtonText}>Login / Register</Text>
          </TouchableOpacity>
        </View>
      </View>
    );
  }

  if (loading) {
    return (
      <View style={styles.container}>
        <ActivityIndicator size="large" color="#007AFF" />
      </View>
    );
  }

  if (!profile) {
    return (
      <View style={styles.container}>
        <Text style={styles.guestTitle}>No profile data found.</Text>
      </View>
    );
  }

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <View style={styles.avatarContainer}>
          <Ionicons name="person-circle" size={80} color="#007AFF" />
        </View>
        <Text style={styles.name}>
          {profile.name && profile.lastname
            ? `${profile.name} ${profile.lastname}`
            : 'User'
          }
        </Text>
        <Text style={styles.email}>{profile.email || 'No email'}</Text>
      </View>


      <View style={styles.menu}>
        {menuItems.map((item, index) => (
          <TouchableOpacity
            key={index}
            style={styles.menuItem}
            onPress={item.onPress}
          >
            <View style={styles.menuItemLeft}>
              <Ionicons 
                name={item.icon} 
                size={24} 
                color={item.color || '#333'} 
              />
              <Text style={[styles.menuItemText, { color: item.color || '#333' }]}>
                {item.title}
              </Text>
            </View>
            <Ionicons name="chevron-forward" size={20} color="#ccc" />
          </TouchableOpacity>
        ))}
      </View>
    </ScrollView>
  );
};

export default ProfileScreen;
